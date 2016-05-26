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
@end
