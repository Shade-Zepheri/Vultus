#import <SpringBoardUI/SBAlertItem.h>
#import "_SBAlertController.h"


@interface SBAlertItem ()

+ (void)activateAlertItem:(SBAlertItem *)alertItem;

- (_SBAlertController *)alertController;

- (void)deactivateForButton;

@end