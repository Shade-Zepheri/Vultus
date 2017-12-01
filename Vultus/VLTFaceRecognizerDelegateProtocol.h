@protocol VLTFaceRecognizerDelegate

- (void)faceRecognized:(NSString *)recognized confidence:(NSInteger)confidence;
- (void)faceRejected;

@end
