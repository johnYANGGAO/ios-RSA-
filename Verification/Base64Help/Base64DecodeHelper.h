//
//  Base64DecodeHelper.h
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/17/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64DecodeHelper : NSObject
/**
 *  解密
 *
 *  @param base64data 加密的字符串
 *
 *  @return 字符串 (正常)
 */
+ (NSString *)base64Decode:(NSString *)base64data;
/**
 *  加密
 *
 *  @param data 字符串 (正常)
 *
 *  @return 加密的字符串
 */
+ (NSString *)base64Encode:(NSString *)data;

@end
