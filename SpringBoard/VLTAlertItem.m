#import "VLTAlertItem.h"

@implementation VLTAlertItem

+ (instancetype)alertItemWithTitle:(NSString *)title andMessage:(NSString *)message {
    return [[self alloc] initWithTitle:title andMessage:message];
}

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message {
    self = [self init];
    if (self) {
        self.title = title;
        self.message = message;
    }

    return self;
}

- (void)configure:(BOOL)animated requirePasscodeForActions:(BOOL)requirePasscode {
    _SBAlertController *alertController = [self alertController];

    NSString *title = self.title;
    alertController.title = title;

    NSString *message = self.message;
    alertController.message = message;

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self deactivateForButton];
    }];

    [alertController addAction:action];
    alertController.preferredAction = action;
}

- (BOOL)dismissOnLock {
    return YES;
}

@end