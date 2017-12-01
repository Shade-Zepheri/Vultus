#import <Vultus/VLTFaceRecognizerDelegateProtocol.h>

@interface VLTSpringBoardListener : NSObject <VLTFaceRecognizerDelegate>

- (void)faceRecognized:(NSString *)recognized confidence:(NSInteger)confidence;
- (void)faceRejected;

@end
