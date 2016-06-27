//
//  VetificationrecordsCell.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "VetificationrecordsCell.h"
#import "Consts.h"
#import "DateUtil.h"


@interface VetificationrecordsCell(){
    
//    UILabel *date;/**时间 */
//    UILabel *labelname;/**姓名*/
//    UILabel *labelproject;/**项目*/
    
}
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *labelname;
@property (weak, nonatomic) IBOutlet UILabel *labelproject;
@end

@implementation VetificationrecordsCell
@synthesize idrecordsmodel;
@synthesize billrecordsmodel;

- (void)setContentForCell:(id) model withType:(NSInteger)type{
    if (type==0) {
        self.idrecordsmodel=model;
        self.date.text=[DateUtil formatDateString:idrecordsmodel.InsertDate withType:0];
        self.labelname.text=idrecordsmodel.UserName;
        self.labelproject.text=idrecordsmodel.Module;
        
    }else if (type==1){
        self.billrecordsmodel=model;
        self.date.text=[DateUtil formatDateString:billrecordsmodel.ViewDate withType:0];
        self.labelname.text=[NSString stringWithFormat:@"%@ 元", billrecordsmodel.TotalMoney];
        self.labelproject.text=[NSString stringWithFormat:@"%d/%d", billrecordsmodel.VBankCount,billrecordsmodel.VIDCardCount];
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
