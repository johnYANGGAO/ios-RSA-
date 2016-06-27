//
//  ExtraInfoModel.h
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *
 *"APIKey": {
 "RSAPriKey": "sample string 1",
 "RSAPubKey": "sample string 2"
 },
 
 * */
@interface ExtraInfoModel : NSObject

@property (copy, nonatomic) NSString *RSAPriKey;
@property (copy, nonatomic) NSString *RSAPubKey;

@end
