@interface SBUICallToActionLabel : UIView

@property (copy, nonatomic) NSString *text;

- (void)setText:(NSString *)text forLanguage:(NSString *)language animated:(BOOL)animated;

@end
