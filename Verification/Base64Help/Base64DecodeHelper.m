//
//  Base64DecodeHelper.m
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/17/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "Base64DecodeHelper.h"

@implementation Base64DecodeHelper

+ (NSString *)base64Decode:(NSString *)base64data{
    
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64data options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded: %@", base64Decoded);
    
    return base64Decoded;
}

+ (NSString *)base64Encode:(NSString *)data{
    
    // Create NSData object
    NSData *nsdata = [data  dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    return base64Encoded;
    
}


@end
