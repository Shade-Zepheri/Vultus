%hook SBLockScreenManager

- (BOOL)_attemptUnlockWithPasscode:(NSString *)passcode mesa:(BOOL)mesa finishUIUnlock:(BOOL)finish {
    BOOL orig = %orig;
    if (!orig) {
        return orig;
    }

    if (passcode && !savedPasscode) {
        savedPasscode = passcode;
    }

    return orig;
}

%end

%hook SBLockScreenActionManager

- (void)runUnlockAction {
    %orig;

    if (!savedPasscode) {
        HBLogWarn(@"No passcode saved. Please unlock with passcode");
    }

    HBLogDebug(@"Passcode retrieved: %@", savedPasscode);
}

%end
