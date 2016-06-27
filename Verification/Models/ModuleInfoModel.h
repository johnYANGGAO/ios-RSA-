//
//  ModuleInfoModel.h
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * "Modules": [
 * {
 * "Type": 1,
 * "Name": "sample string 2",
 * "MinFee": 3.1
 * },
 * {
 * "Type": 1,
 * "Name": "sample string 2",
 * "MinFee": 3.1
 * }
 * ],
 */

@interface ModuleInfoModel : NSObject

@property (assign, nonatomic) unsigned int Type;
@property (copy, nonatomic) NSString *Name;
@property (strong, nonatomic) NSNumber *MinFee;

@end
