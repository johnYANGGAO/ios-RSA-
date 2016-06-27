//
//  AESUtil.m
//  Verification
//
//  Created by john's mac　　　　 on 6/1/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "AESUtil.h"

@implementation AESUtil
/** Generates a 256 bits cryptographically secure key.
 * The output will be a 44 characters base 64 string (32 bytes data
 * before the base 64 encoding).
 * @return A base 64 encoded 256 bits secure key.
 只适合 同平台
 */
 
+ (NSString*)generateSecureKey
{
    NSMutableData *data = [NSMutableData dataWithLength:32];
    int result = SecRandomCopyBytes(kSecRandomDefault, 32, data.mutableBytes);
    if (result != noErr) {
        return nil;
    }
    NSString *str =[data base64EncodedStringWithOptions:kNilOptions];

    return str;
}
//通用的key
+ (NSString *)generateAESKey{
   
        NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789=+";
        NSMutableString *s = [NSMutableString stringWithCapacity:32];
        for (NSUInteger i = 0; i < 32; i++) {
            u_int32_t r = arc4random() % [alphabet length];//modulo bias?
            unichar c = [alphabet characterAtIndex:r];
            [s appendFormat:@"%C", c];
        }
        NSString *key = s;
    return key;
    
}

+ (NSMutableData *)encryptor:(NSData *)original withKey:(NSString *)key andIV:(NSString *)iv{
    
    
    RNEncryptor *encryptor = [[RNEncryptor alloc] initWithPassword:key];
    NSMutableData *ciphertext = [NSMutableData new];
    
    // ... Each time data comes in, update the encryptor and accumulate some ciphertext ...
    [ciphertext appendData:[encryptor updateWithData:original]];
    
    // ... When data is done, finish up ...
    [ciphertext appendData:[encryptor finalData]];
    
    
    NSLog(@"encryptor data is %@",ciphertext);
    return ciphertext;
}
+ (NSMutableData *)decryptor:(NSData *)encryptedData  withKey:(NSString *)key{


        // Decryption
        //
        RNDecryptor *decryptor = [[RNDecryptor alloc] initWithPassword:key];
        NSMutableData *plaintext = [NSMutableData new];
    
        // ... Each time data comes in, update the decryptor and accumulate some plaintext ...
        NSError *error = nil;
        NSData *partialPlaintext = [decryptor updateWithData:encryptedData error:&error];
        if (error != nil) {
            NSLog(@"FAILED DECRYPT: %@", error);
            return  nil;
        }
        [plaintext appendData:partialPlaintext];
    
        // ... When data is done, finish up ...
        NSError *errora = nil;
        NSData *partialPlaintexta = [decryptor finalDataAndReturnError:&errora];
        if (error != nil) {
            NSLog(@"FAILED DECRYPT: %@", error);
            return nil;
        }
    
        [plaintext appendData:partialPlaintexta];
        NSLog(@"decryptor data is %@",plaintext);
    
    return plaintext;


}
/*
add IV  256
=====================================================================================
*/


+ (NSData *)crypto:(NSData *)data operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
    
    // Key
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV  16 maps 128
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    NSInteger diff = kCCKeySizeAES256 - (dataLength % kCCKeySizeAES256);
    NSInteger newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    size_t bufferSize = newSize+ kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, 0x0000,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            dataPtr,
                                            sizeof(dataPtr),
                                            buffer,
                                            bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        NSLog(@"cryptorStatus == kCCSuccess");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else{
        NSLog(@"cryptorStatus != kCCSuccess");
    }
    
    free(buffer);
    return nil;
}
/**
 *  another way prepare for decrypt
 *
 *  @param data      <#data description#>
 *  @param operation <#operation description#>
 *  @param key       <#key description#>
 *  @param iv        <#iv description#>
 *
 *  @return <#return value description#>
 */
- (NSData *)crypto:(NSData *)data operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv{
    
    char keyPtr[kCCKeySizeAES256 + 1];//如果要256 则key长度 要对应32
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
      [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return  [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }else{
        NSLog(@"cryptorStatus != kCCSuccess");
    }

    free(buffer);
    return nil;
}



+ (NSString *)AESencrypt:(NSString *)originalStr  withKey:aesKey
{
    
    NSData *data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *iv = @"0000000000000000";
    // 暗号化
    NSData *dataEncrypted = [ self crypto:data operation:kCCEncrypt key:aesKey iv:iv];
    
    return [dataEncrypted base64EncodedStringWithOptions:0];
}


+ (NSString *)AESdecrypt:(NSString *)encryptedStr withKey:aesKey{
    NSString *iv = @"0000000000000000";
    NSData * datade=[[NSData alloc] initWithBase64EncodedString:encryptedStr options:0];
    NSData *dataDecrypted = [self crypto:datade operation:kCCDecrypt key:aesKey iv:iv];
    
    NSString *stringDecrypted = [[NSString alloc] initWithData:dataDecrypted encoding:NSUTF8StringEncoding];
    NSLog(@"stringDecrypted is : %@", stringDecrypted);
    
    return stringDecrypted;

}

@end
