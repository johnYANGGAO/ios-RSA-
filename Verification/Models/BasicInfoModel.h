//
//  BasicInfoModel.h
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * "Basic": {
 * "CompanyName": "sample string 1",
 * "Status": 1,
 * "Province": "sample string 2",
 * "City": "sample string 3",
 * "Address": "sample string 4",
 * "LegalPerson": "sample string 5",
 * "LegalMobile": "sample string 6",
 * "LegalTel": "sample string 7",
 * "ContactPerson": "sample string 8",
 * "ContactDept": "sample string 9",
 * "ContactTel": [
 * "sample string 1",
 * "sample string 2"
 * ],
 * "ContactEmail": "sample string 10",
 * "CompanyURL": "sample string 11",
 * "InsertDate": "2016-04-17T09:15:51.2283874+08:00"
 * },
 */

@interface BasicInfoModel : NSObject<NSCoding>
//基本信息可能会修改改变 暂时用copy
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *Province;
@property (copy, nonatomic) NSString *City;
@property (copy, nonatomic) NSString *Address;
@property (copy, nonatomic) NSString *LegalPerson;

@property (copy, nonatomic) NSString *LegalMobile;
@property (copy, nonatomic) NSString *LegalTel;
@property (copy, nonatomic) NSString *ContactPerson;
@property (copy, nonatomic) NSString *ContactDept;

@property (copy, nonatomic) NSMutableArray *ContactTel;

@property (copy, nonatomic) NSString *ContactEmail;

@property (copy, nonatomic) NSString *CompanyURL;
@property (copy, nonatomic) NSString *InsertDate;
@property (copy, nonatomic) NSString *Status;
@end
