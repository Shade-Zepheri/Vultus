@class SBDashBoardMainPageViewController;

@interface SBDashBoardViewController : UIViewController

@property (setter=_setPageViewControllers:, copy, nonatomic) NSArray *pageViewControllers;

@property (setter=_setMainPageViewController:, strong, nonatomic) SBDashBoardMainPageViewController *mainPageViewController;

@end
