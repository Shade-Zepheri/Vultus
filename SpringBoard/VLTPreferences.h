@interface VLTPreferences : NSObject

@property (readonly, nonatomic) BOOL enabled;
@property (strong, nonatomic) NSData *savedPasscodeData;

+ (instancetype)sharedSettings;

@end
