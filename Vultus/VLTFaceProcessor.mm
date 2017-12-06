#import "VLTFaceProcessor.h"
#import "VLTDelegateManager.h"

@implementation VLTFaceProcessor

+ (instancetype)mainProcessor {
    static VLTFaceProcessor *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.running = NO;
    }

    return self;
}

@end
