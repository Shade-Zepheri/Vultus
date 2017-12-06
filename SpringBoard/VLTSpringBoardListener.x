#import <libMobileGestalt/libMobileGestalt.h>
#import <SpringBoard/SBLockScreenManager+Private.h>
#import "VLTSpringBoardListener.h"

@implementation VLTSpringBoardListener

- (void)faceRecognized:(NSString *)recognized confidence:(NSInteger)confidence {
    //Change push to unlock text

    NSData *encryptedPasscode = [VLTPreferences sharedSettings].savedPasscodeData;
    NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);

    NSData *passcodeData = [encryptedPasscode AES256DecryptedDataWithKey:udid];
    NSString *savedPasscode = [[NSString alloc] initWithData:passcodeData encoding:NSUTF8StringEncoding];

    SBLockScreenManager *manager = [%c(SBLockScreenManager) sharedInstance];
    [manager attemptUnlockWithPasscode:savedPasscode]
}

- (void)faceRejected {
    //Change push to unlock text
}

@end
