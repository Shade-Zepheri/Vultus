#import <SpringBoard/SBLockScreenManager.h>

@class SBDashBoardViewController;

@interface SBLockScreenManager (Private)

@property (readonly, nonatomic) SBDashBoardViewController *dashBoardViewController;

- (void)attemptUnlockWithPasscode:(NSString *)passcode;

@end
