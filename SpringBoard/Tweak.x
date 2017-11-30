#import "VLTPreferences.h"
#import "NSData+AES.h"

static NSString *savedPasscode;

%hook SBLockScreenManager

- (BOOL)_attemptUnlockWithPasscode:(NSString *)passcode mesa:(BOOL)mesa finishUIUnlock:(BOOL)finish {
    BOOL orig = %orig;
    if (savedPasscode && [savedPasscode isEqualToString:passcode]) {
        return orig;
    }

    if (passcode) {
        savedPasscode = passcode;

        NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(CFSTR("UniqueDeviceID"));
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
        HBLogWarn(@"No passcode saved. Please unlock with passcode");
    }
}

%end

%ctor {
    NSData *encryptedPasscode = [VLTPreferences sharedSettings].savedPasscodeData;
    NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(CFSTR("UniqueDeviceID"));

    NSData *passcodeData = [encryptedPasscode AES256DecryptedDataWithKey:udid];
    savedPasscode = [NSString stringWithUTF8String:[[[NSString alloc] initWithData:passcodeData encoding:NSUTF8StringEncoding] UTF8String]];
}
