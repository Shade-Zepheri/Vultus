#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import <notify.h>

@interface VLTFlipswitchSwitch : NSObject <FSSwitchDataSource>
@end

@implementation VLTFlipswitchSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
		Boolean keyExistsAndHasValidFormat;
		BOOL enabled = CFPreferencesGetAppBooleanValue(CFSTR("Enabled"), CFSTR("com.shade.vultus"), &keyExistsAndHasValidFormat);

		return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
		if (newState == FSSwitchStateIndeterminate) {
				return;
		}

		CFPreferencesSetAppValue(CFSTR("Enabled"), (CFPropertyListRef)(newState == FSSwitchStateOn ? @YES : @NO), CFSTR("com.shade.vultus"));
		notify_post("com.shade.vultus/ReloadPrefs");
}

@end
