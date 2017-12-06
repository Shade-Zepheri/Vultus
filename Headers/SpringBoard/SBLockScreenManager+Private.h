#import <SpringBoard/SBLockScreenManager.h>

@interface SBLockScreenManager (Private)

- (void)attemptUnlockWithPasscode:(NSString *)passcode;

@end
