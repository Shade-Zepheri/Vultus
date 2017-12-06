#import <libMobileGestalt/libMobileGestalt.h>
#import <Vultus/VLTDelegateManager.h>
#import "VLTPreferences.h"
#import "VLTSpringBoardListener.h"
#import "NSData+AES.h"
#import "UIAlertController+Window.h"

static NSString *savedPasscode;
static VLTSpringBoardListener *listener;

%hook SBLockScreenManager

- (BOOL)_attemptUnlockWithPasscode:(NSString *)passcode mesa:(BOOL)mesa finishUIUnlock:(BOOL)finish {
    BOOL orig = %orig;
    if (savedPasscode && [savedPasscode isEqualToString:passcode]) {
        return orig;
    }

    if (passcode) {
        savedPasscode = passcode;

        NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
        NSData *encryptedPasscode = [[savedPasscode dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataWithKey:udid];
        [VLTPreferences sharedSettings].savedPasscodeData = encryptedPasscode;
    }

    return orig;
}

%end

%hook SBLockScreenActionManager

- (void)runUnlockAction {
    %orig;

    if (!savedPasscode) {
        NSString *message = @"No passcode saved. Vultus requires your passcode in order to unlock the device (Your passcode in encrypted for safety reasons). Please unlock with your passocde"
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Vultus" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]

        [alert addAction:action];
        [alert show];
    }
}

%end

%ctor {
    NSData *encryptedPasscode = [VLTPreferences sharedSettings].savedPasscodeData;
    NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);

    NSData *passcodeData = [encryptedPasscode AES256DecryptedDataWithKey:udid];
    savedPasscode = [[NSString alloc] initWithData:passcodeData encoding:NSUTF8StringEncoding];
    //[NSString stringWithUTF8String:passcodeData.bytes];

    listener = [[VLTSpringBoardListener alloc] init];
    [[VLTDelegateManager defaultManager] registerDelegate:listener];
}
