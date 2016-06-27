//
//  NSString+MD5.m
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/17/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)MD5 {
    
    const char * pointer = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
    
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [string appendFormat:@"%02x",md5Buffer[i]];
    
    return string;
}
- (NSString *)addStarNumber {
    //星号字符串
    NSString *starStr = @"";
    //动态计算星号的个数
    for (int i  = 0; i < self.length - 8; i++) {
        starStr = [starStr stringByAppendingString:@"*"];
    }
    //返回处理好的身份证号
    return [NSString stringWithFormat:@"%@%@%@",[self substringToIndex:4],starStr,[self substringFromIndex:self.length-4]];
}
@end
