//
//  IDRecordsModelData.h
//  Verification
//
//  Created by john's mac　　　　 on 6/17/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//
/*
 {"Data":[{"CompanyID":"d9d64b67776543a89338d31c7d55c52b","ExpenseUserID":"48b5a42cf73344a8adc5d22aa7ea6376","IP":"","ModuleType":1,"Module":"银行卡验证","BankCardNo":"140431198504284814","IDCardNo":"6236690010001415298","TelephoneNo":"15101031065","UserName":"康二军","Fee":0.6,"ResultCode":"00","Result":"信息一致","InsertDate":"2016-06-07T11:43:43.527+08:00","ID":"58fb262c197c4c35992cd3cb4d6561b3"},{
 ...
 },{
 ...
 }],"Total":12870,"Next_id":11,"Result":0,"Exception":"操作成功"
 }
*/
#import <Foundation/Foundation.h>

@interface IDRecordsModelData : NSObject

@property (strong ,nonatomic) NSMutableArray *Data;
@property (nonatomic ,assign) NSInteger Total;
@property (nonatomic ,assign) NSInteger Next_id;
@property (nonatomic ,assign) NSInteger Result;
@property (nonatomic ,assign) NSString *Exception;


@end
