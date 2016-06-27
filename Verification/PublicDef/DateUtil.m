//
//  DateUtil.m
//  Verification
//
//  Created by john's mac　　　　 on 4/8/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil
//NSDate转NSString
+ (NSString *)stringFromDate:(NSString *)datetype
{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:datetype];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

//处理.net 返回的特殊时间格式
+ (NSString *)formatDateString:(NSString *)datestring withType:(NSInteger)type{
//2016-05-23T10:17:34.786+08:00
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yy-MM-dd hh:mm"];
//    NSDate* date = [dateFormatter dateFromString:datestring];
//    if (0==type) {
//        [dateFormatter setDateFormat:@"yy-MM-dd hh:mm"];
//
//    }else if(1==type){
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    }
//    return [dateFormatter stringFromDate:date];
    NSString* input = datestring;
    
    NSString* year  = [input substringWithRange: NSMakeRange( 0, 4)];
    NSString* month = [input substringWithRange: NSMakeRange( 5, 2)];
    NSString* day   = [input substringWithRange: NSMakeRange( 8, 2)];
    NSString* time  = [input substringWithRange: NSMakeRange(11, 8)];
    NSString* output = nil;
    if(0==type){
        output = [NSString stringWithFormat:@"%@/%@/%@ ",day,month,year];
    }else if (1==type){
        output = [NSString stringWithFormat:@"%@/%@/%@ %@ ",day,month,year,time];
    }
    return output;
}


@end
