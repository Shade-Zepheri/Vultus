#import "VLTDatabaseHelper.h"

@interface VLTFaceProcessor : NSObject
@property (assign, nonatomic) BOOL running;

+ (instancetype)mainProcessor;

- (void)start;
- (void)stop;

@end
