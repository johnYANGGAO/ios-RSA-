//
//  UserInfoModel.h
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfoModel.h"
#import "BasicInfoModel.h"
#import "ExtraInfoModel.h"

@interface UserInfoModel : NSObject<NSCoding>

@property (strong, nonatomic) AccountInfoModel *Account;
@property (strong, nonatomic) BasicInfoModel *Basic;
@property (strong, nonatomic) ExtraInfoModel *APIKey;
@property (strong, nonatomic) NSMutableArray *Modules;

@end
