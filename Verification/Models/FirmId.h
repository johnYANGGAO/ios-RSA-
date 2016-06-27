//
//  FirmId.h
//  Verification
//
//  Created by john's mac　　　　 on 6/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//
/*Data =     {
    CompanyID = d9d64b67776543a89338d31c7d55c52b;
    ID = 48b5a42cf73344a8adc5d22aa7ea6376;
    Login = admin;
    Pwd = E3F4B0456902DB0E3274D079D32652FA;
    Roles = 1;
    Status = 1;
};

*/

#import <Foundation/Foundation.h>

@interface FirmId : NSObject
@property (nonatomic ,strong) NSString *CompanyID;
@property (nonatomic ,strong) NSString *ID;
@property (nonatomic ,strong) NSString *Login;
@property (nonatomic ,strong) NSString *Pwd;
@property (nonatomic ,assign) NSInteger Roles;
@property (nonatomic ,assign) NSInteger Status;

@end
