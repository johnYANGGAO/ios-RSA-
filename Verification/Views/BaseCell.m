//
//  BaseCell.m
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

@synthesize vertificationCategory;
@synthesize flag;
- (void)awakeFromNib{
    
}
- (void)setLabel:(NSDictionary *)dic{
    vertificationCategory.text= [dic objectForKey:@"title"];
    UIImage *img=[UIImage imageNamed:[dic objectForKey:@"image"]];
    if(img){
      flag.image=img;
    }else{
        NSLog(@"bundle 图片没找到");
    }
}
@end
