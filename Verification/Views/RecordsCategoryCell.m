//
//  RecordsCategoryCell.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "RecordsCategoryCell.h"

@implementation RecordsCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContentForCategoryCell:(NSDictionary *)dic{
    
    self.title.text=[dic objectForKey:@"title"];
    UIImage *img=[UIImage imageNamed:[dic objectForKey:@"image"]];
    if(img){
        self.image.image=img;
    }else{
        NSLog(@"there is nothing found about image");
    }


}

@end
