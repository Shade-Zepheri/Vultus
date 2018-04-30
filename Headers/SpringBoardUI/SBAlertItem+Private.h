#import "_SBAlertController.h"

@interface SBAlertItem : NSObject

+ (void)activateAlertItem:(SBAlertItem *)alertItem;

- (_SBAlertController *)alertController;

- (void)configure:(BOOL)configure requirePasscodeForActions:(BOOL)requirePasscode;
- (void)deactivateForButton;

@end