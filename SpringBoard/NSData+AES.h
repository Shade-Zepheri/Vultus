/**
 http://mythosil.hatenablog.com/entry/20111017/1318873155
 http://blog.dealforest.net/2012/03/ios-android-per-aes-crypt-connection/
 */

@interface NSData (AES)

- (NSData *)AES256EncryptedDataWithKey:(NSString *)key;
- (NSData *)AES256DecryptedDataWithKey:(NSString *)key;
- (NSData *)AES256EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES256DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv;

@end
