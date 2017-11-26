#import "VLTPreferences.h"

static NSString *const kVLTPreferencesEnabledKey = @"Enabled";

@implementation VLTPreferences {
	HBPreferences *_preferences;
}

+ (instancetype)sharedInstance {
    static VLTPreferences *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _preferences = [HBPreferences preferencesForIdentifier:@"com.shade.vultus"];

        [_preferences registerBool:&_enabled default:YES forKey:kVLTPreferencesEnabledKey];
    }

    return self;
}
