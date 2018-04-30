#import "VLTPreferences.h"
#import <Cephei/HBPreferences.h>

// Settings keys
static NSString *const kVLTPreferencesEnabledKey = @"Enabled";

static NSString *const kVLTPreferencesSavedPasscodeKey = @"PasscodeData";

@implementation VLTPreferences {
    HBPreferences *_preferences;
}

+ (instancetype)sharedSettings {
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

- (NSData *)savedPasscodeData {
    return [_preferences objectForKey:kVLTPreferencesSavedPasscodeKey];
}

- (void)setSavedPasscodeData:(NSData *)data {
    [_preferences setObject:data forKey:kVLTPreferencesSavedPasscodeKey];
}

@end
