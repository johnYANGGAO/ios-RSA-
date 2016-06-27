//
//  BillRecordsModelData.h
//  Verification
//
//  Created by john's mac　　　　 on 6/17/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillRecordsModel.h"
/**{
 "Data": [
 {
 "CompanyID":"d9d64b67776543a89338d31c7d55c52b","ViewDate":"2016-04-19T00:00:00+08:00","TotalMoney":1.2,"VBankCount":2,"VIDCardCount":0,"VBankSucceed":0,"VIDCardSucceed":0,"VBankCharging":2,"VIDCardCharging":0,"ID":"333c4bc9445f412bb1dced765a28f1c3"
 },
 {.....
 }
 ],
 ,"TotalData":{"CompanyID":"d9d64b67776543a89338d31c7d55c52b","ViewDate":"0001-01-01T00:00:00","TotalMoney":64.8,"VBankCount":91,"VIDCardCount":27,"VBankSucceed":39,"VIDCardSucceed":0,"VBankCharging":87,"VIDCardCharging":20,"ID":"326b29cc58814bb7ac4afaa0f4b9bd48"},
 "Total":20,
 "Next_id":10,
 "Result":0,
 "Exception":"操作成功"
 }
 
 */

@interface BillRecordsModelData : NSObject

@property (strong ,nonatomic) NSMutableArray *Data;
@property (nonatomic ,assign) NSInteger Total;
@property (nonatomic ,assign) NSInteger Next_id;
@property (nonatomic ,assign) NSInteger Result;
@property (nonatomic ,assign) NSString *Exception;
@property (nonatomic ,strong) BillRecordsModel *TotalData;

@end
