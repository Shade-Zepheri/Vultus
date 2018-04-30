#import <Vultus/VLTFaceRecognizerObserver.h>

@interface VLTSpringBoardListener : NSObject <VLTFaceRecognizerObserver>

- (void)faceRecognized:(NSString *)recognized confidence:(NSInteger)confidence;
- (void)faceRejected;

@end
