#import "VLTFaceRecognizerDelegateProtocol.h"

@interface VLTDelegateManager : NSObject
@property (strong, nonatomic) NSMutableArray *delegates;

+ (instancetype)defaultManager;

- (void)registerDelegate:(id<VLTFaceRecognizerDelegate>)delegate;
- (void)deregisterDelegate:(id<VLTFaceRecognizerDelegate>)delegate;

@end
