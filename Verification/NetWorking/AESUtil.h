//
//  AESUtil.h
//  Verification
//
//  Created by john's mac　　　　 on 6/1/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
@import RNCryptor;

@interface AESUtil : NSObject

+ (NSString *)generateSecureKey;
+ (NSString *)generateAESKey;
//AES encrypts bytes. It does not encrypt characters, letters, words, pictures, videos, cats, or ennui. It encrypts bytes. You need to convert other things (such as strings) to and from bytes in a consistent way.
//+ (NSMutableData *)encryptor:(NSData *)original withKey:(NSString *)key andIV:(NSString *)iv;
//+ (NSMutableData *)decryptor:(NSData *)encryptedData  withKey:(NSString *)key;
+ (NSData *)crypto:(NSData *)data operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv;

+ (NSString *)AESencrypt:(NSString *)originalStr  withKey:aesKey;
+ (NSString *)AESdecrypt:(NSString *)encryptedStr withKey:aesKey;

@end
