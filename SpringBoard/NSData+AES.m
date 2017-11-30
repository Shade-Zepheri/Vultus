#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AES)

- (NSData *)AES256EncryptedDataWithKey:(NSString *)key {
    return [self AES256EncryptedDataWithKey:key iv:nil];
}

- (NSData *)AES256DecryptedDataWithKey:(NSString *)key {
    return [self AES256DecryptedDataWithKey:key iv:nil];
}

- (NSData *)AES256EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv {
    return [self AES256Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)AES256DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv {
    return [self AES256Operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)AES256Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    if (iv) {
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }

    NSUInteger dataLength = self.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES256,
                                          ivPtr,
                                          self.bytes, dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end
