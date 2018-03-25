#import <SpringBoardUI/SBAlertItem+Private.h>

@interface VLTAlertItem : SBAlertItem
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *message;

+ (instancetype)alertItemWithTitle:(NSString *)title andMessage:(NSString *)message;
- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message;

@end