#import "VLTAlertItem.h"
#import "VLTPreferences.h"
#import "VLTSpringBoardListener.h"
#import "NSData+AES.h"
#import <MobileGestalt/MobileGestalt.h>
#import <Vultus/VLTDelegateManager.h>

static VLTPreferences *preferences;
static NSString *savedPasscode;
static VLTSpringBoardListener *listener;

#pragma mark - Hooks

%hook SBLockScreenManager

- (BOOL)_attemptUnlockWithPasscode:(NSString *)passcode mesa:(BOOL)mesa finishUIUnlock:(BOOL)finish {
    BOOL orig = %orig;

    // Return if passcode hasnt changed
    if (savedPasscode && [savedPasscode isEqualToString:passcode]) {
        return orig;
    }

    // Change saved passcode if different
    if (passcode) {
        savedPasscode = passcode;

        NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
        NSData *encryptedPasscode = [[savedPasscode dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataWithKey:udid];
        preferences.savedPasscodeData = encryptedPasscode;
    }

    return orig;
}

%end

%hook SBLockScreenActionManager

- (void)runUnlockAction {
    %orig;

    // Alert user if no saved pascode
    if (savedPasscode) {
        return;
    }

    NSString *message = @"No passcode saved. Vultus requires your passcode in order to unlock the device (Your passcode in encrypted for safety reasons). Please unlock with your passocde";
    VLTAlertItem *alertItem = [%c(VLTAlertItem) alertItemWithTitle:@"Vultus" andMessage:message];
    [alertItem.class activateAlertItem:alertItem];
}

%end

#pragma mark - Constructor

%ctor {
    // Create singletons
    preferences = [VLTPreferences sharedSettings];

    // Get passcode
    NSData *encryptedPasscode = preferences.savedPasscodeData;
    NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);

    NSData *passcodeData = [encryptedPasscode AES256DecryptedDataWithKey:udid];
    savedPasscode = [[NSString alloc] initWithData:passcodeData encoding:NSUTF8StringEncoding];

    // Register listener
    listener = [[VLTSpringBoardListener alloc] init];
    [[VLTDelegateManager defaultManager] addObserver:listener];
}
