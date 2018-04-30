#import "VLTSpringBoardListener.h"
#import "VLTPreferences.h"
#import "NSData+AES.h"
#import <MobileGestalt/MobileGestalt.h>
#import <SpringBoard/SBLockScreenManager+Private.h>
#import <SpringBoard/SBDashBoardMainPageContentViewController.h>
#import <SpringBoard/SBDashBoardMainPageView.h>
#import <SpringBoard/SBDashBoardMainPageViewController.h>
#import <SpringBoard/SBDashBoardViewController.h>
#import <SpringBoardUIServices/SBUICallToActionLabel.h>

@implementation VLTSpringBoardListener

- (void)faceRecognized:(NSString *)recognized confidence:(NSInteger)confidence {
    //Change push to unlock text
    NSString *text = [NSString stringWithFormat:@"Recognizer %@", recognized];
    [self updateCallToActionText:text];

    // Unencrypt data
    NSData *encryptedPasscode = [VLTPreferences sharedSettings].savedPasscodeData;
    NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);

    NSData *passcodeData = [encryptedPasscode AES256DecryptedDataWithKey:udid];
    NSString *savedPasscode = [[NSString alloc] initWithData:passcodeData encoding:NSUTF8StringEncoding];

    // Unlock device
    SBLockScreenManager *manager = [%c(SBLockScreenManager) sharedInstance];
    [manager attemptUnlockWithPasscode:savedPasscode];
}

- (void)faceRejected {
    //Change push to unlock text
    [self updateCallToActionText:@"Face not recognized"];
}

- (void)updateCallToActionText:(NSString *)message {
    //Beautiful block of code just to access label
    SBLockScreenManager *manager = [%c(SBLockScreenManager) sharedInstance];
    SBDashBoardViewController *dashBoardViewController = manager.dashBoardViewController;
    SBDashBoardMainPageViewController *mainPageViewController = dashBoardViewController.mainPageViewController;
    SBDashBoardMainPageContentViewController *contentViewController = mainPageViewController.contentViewController;
    SBDashBoardMainPageView *mainPage = [contentViewController _dashBoardMainPageView];
    SBUICallToActionLabel *callToActionLabel = mainPage.callToActionLabel;

    // Change text
    [callToActionLabel setText:message forLanguage:nil animated:YES];
}

@end
