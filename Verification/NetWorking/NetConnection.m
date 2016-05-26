//
//  NetConnection.m
//  Verification
//
//  Created by john's mac　　　　 on 4/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "NetConnection.h"

static dispatch_once_t predicate;

@interface NetConnection(){
    
    NSString *currentElement;
    NSMutableData *webResponseData;
}

@end

@implementation NetConnection

+ (NetConnection *)sharedManager{
    
    static NetConnection *netConnection=nil;
    
    dispatch_once(&predicate,^{
        netConnection = [[self alloc] init];
    });
    return netConnection;
}


- (void)requestPostData:(id)parameters netUrl:(NSString *)url successBlock:(SuccessBlock)success failureBlock:(ErrorBlock)failure{
    
    NSURL *postRequestUrl = [NSURL URLWithString:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    /**
     *  //摒弃以前的序列化方式，否则报－1016错 但成功返回的数据 是NSData类型的
     */
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //     manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    /**
     *  Header
     */
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    [manager.requestSerializer setValue:@"bjjyshow" forHTTPHeaderField:@"LoginName"];
//    [manager.requestSerializer setValue:@"bjjyshow" forHTTPHeaderField:@"Pwd"];
//    [manager.requestSerializer setValue:@"3" forHTTPHeaderField:@"RoleID"];
    
    NSURLSessionDataTask *dataTask=[manager POST:postRequestUrl.absoluteString  parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@ ",responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
        failure(error.localizedDescription);
        
    }];
    [dataTask resume];
    
}

- (void)requestGetData:(id)parameters  netUrl:(NSString *)url  successBlock:(SuccessBlock)success failureBlock:(ErrorBlock)failure{
    
    NSURL *getRequestUrl = [NSURL URLWithString:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *dataTask=[manager GET:getRequestUrl.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@ ",responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
        failure(error.localizedDescription);
        
    }];
    [dataTask resume];
    
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr{
    if (jsonStr == nil) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSDictionary *)dictionaryWithData:(NSData *)data{
    
    if (data == nil) {
        return nil;
    }
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
