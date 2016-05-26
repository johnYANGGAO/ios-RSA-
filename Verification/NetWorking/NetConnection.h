//
//  NetConnection.h
//  Verification
//
//  Created by john's mac　　　　 on 4/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define NETTIMEOUT 20

typedef void(^SuccessBlock)(id responseBody);
typedef void(^ErrorBlock)(NSString *error);


@interface NetConnection : NSObject

+ (NetConnection *)sharedManager;

- (void)requestPostData:(id)parameters netUrl:(NSString *)url successBlock:(SuccessBlock)success failureBlock:(ErrorBlock)failure;

- (void)requestGetData:(id)parameters netUrl:(NSString *)url successBlock:(SuccessBlock)success failureBlock:(ErrorBlock)failure;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr;

- (NSDictionary *)dictionaryWithData:(NSData *)data;


@end

