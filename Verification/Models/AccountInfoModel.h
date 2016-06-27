//
//  AccountInfoModel.h
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * "Account": {
 * "Beforehand": 1,
 * "Deposit": 2.1,
 * "Money": 3.1,
 * "TotalExpeditureMoney": 4.1,
 * "WarnLimit": 5.1,
 * "IsOpenWarn": 6,
 * "Phone": [
 * "sample string 1",
 * "sample string 2"
 * ],
 * "Email": [
 * "sample string 1",
 * "sample string 2"
 * ]
 * },
 */

@interface AccountInfoModel : NSObject<NSCoding>

@property (assign, nonatomic) unsigned int Beforehand;
@property (assign, nonatomic) int IsOpenWarn;
@property (strong, nonatomic) NSString *Money;
@property (strong, nonatomic) NSString *Deposit;
@property (strong, nonatomic) NSString *TotalExpeditureMoney;
@property (strong, nonatomic) NSString *WarnLimit;


@property (strong, nonatomic) NSMutableArray *Phone;
@property (strong, nonatomic) NSMutableArray *Email;




@end
