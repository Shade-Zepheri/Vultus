#import <Cephei/HBPreferences.h>

@interface VLTPreferences : NSObject

@property (nonatomic, readonly) BOOL enabled;

+ (instancetype)sharedSettings;

@end
