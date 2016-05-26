//
//  VetificationrecordsCell.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "VetificationrecordsCell.h"
#import "Consts.h"
@interface VetificationrecordsCell(){
    
    UILabel *date;/**时间 */
    UILabel *labelname;/**姓名*/
    UILabel *labelproject;/**项目*/
    
}
@end

@implementation VetificationrecordsCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews{
    
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 55)];
    cellView.backgroundColor=[UIColor whiteColor];
    
    date = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screen_width/3,cellView.frame.size.height)];
    date.textAlignment = NSTextAlignmentCenter;
    date.textColor = [UIColor lightGrayColor];
    date.font = [UIFont systemFontOfSize:16];
    [cellView addSubview:date];
    
    
    labelname = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(date.frame),0, screen_width/3,cellView.frame.size.height)];
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor lightGrayColor];
    labelname.font = [UIFont systemFontOfSize:16];
    
    
    [cellView addSubview:labelname];
    
    labelproject = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labelname.frame),0, screen_width/3,cellView.frame.size.height)];
    labelproject.textAlignment = NSTextAlignmentCenter;
    labelproject.textColor = [UIColor lightGrayColor];
    labelproject.font = [UIFont systemFontOfSize:16];
    
    [cellView addSubview:labelproject];
    
    [self addSubview:cellView];
}

- (void)setContentForCell:(BaseModel *) model{
    if (self.type==0) {
        date.text=model.time;
        labelname.text=model.name;
        labelproject.text=model.project;
        
    }else if (self.type==1){
        date.text=model.time;
        labelname.text=model.money;
        labelproject.text=model.category;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
