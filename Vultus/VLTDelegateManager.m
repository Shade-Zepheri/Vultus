#import "VLTDelegateManager.h"

@implementation VLTDelegateManager

+ (instancetype)defaultManager {
    static VLTDelegateManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegates = [NSMutableArray array];
    }

    return self;
}

- (void)registerDelegate:(id<VLTFaceRecognizerDelegate>)delegate {
    if ([self.delegates containsObject:delegate] || !delegate) {
        return;
    }

    [self.delegates addObject:delegate];
}

- (void)deregisterDelegate:(id<VLTFaceRecognizerDelegate>)delegate {
    if (![self.delegates containsObject:delegate] || !delegate) {
        return;
    }

    [self.delegates removeObject:delegate];
}

- (void)faceRecognized:(BOOL)recognized person:(NSString *)person confidence:(NSInteger)confidence {
    for (id<VLTFaceRecognizerDelegate> delegate in self.delegates) {
        if (recognized && [delegate respondsToSelector:(@selector(faceRecognized:confidence:))]) {
            [delegate faceRecognized:person confidence:confidence];
        } else if ([delegate respondsToSelector:(@selector(faceRejected))]) {
            [delegate faceRejected];
        }
    }
}


@end
