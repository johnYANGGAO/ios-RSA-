//
//  AccountInfoDisplayer.m
//  Verification
//
//  Created by john's mac　　　　 on 6/22/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "AccountInfoDisplayer.h"


@interface AccountInfoDisplayer(){

}
@property (weak, nonatomic) IBOutlet UILabel *restmoney;
@property (weak, nonatomic) IBOutlet UILabel *deposit;
@property (weak, nonatomic) IBOutlet UILabel *beforehand;
@property (weak, nonatomic) IBOutlet UILabel *warnlimit;
@property (weak, nonatomic) IBOutlet UILabel *iswarnopen;
@property (weak, nonatomic) IBOutlet UILabel *totalspent;
- (IBAction)backup:(UIBarButtonItem *)sender;

@end

@implementation AccountInfoDisplayer
@synthesize accountinfo;
-(void)viewDidLoad{

    [super viewDidLoad];
    [self initViews];

}

- (void)initViews{
    
    if (accountinfo) {
        self.restmoney.text=[NSString stringWithFormat:@"%.2f元",[accountinfo.Money floatValue]];
        self.deposit.text=[NSString stringWithFormat:@"%.2f元",[accountinfo.Deposit floatValue]];
        self.beforehand.text=(accountinfo.Beforehand==1?@"预付费用户":@"后预付费用户");
        self.warnlimit.text=[NSString stringWithFormat:@"%.2f元",[accountinfo.WarnLimit floatValue]];
        self.iswarnopen.text=(accountinfo.IsOpenWarn<0?@"关闭":@"开启");
        self.totalspent.text=[NSString stringWithFormat:@"%.2f元",[accountinfo.TotalExpeditureMoney floatValue]];
    }
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     NSMutableString *numbers=[[NSMutableString alloc]initWithCapacity:0];
     NSString *title=@"";
    if(indexPath.section==1){
        
        if (indexPath.row==0) {
            title=@"手机号码";
            for (int i=0; i<accountinfo.Phone.count; i++) {
                
                [numbers appendString:accountinfo.Phone[i]];
                if (i>1&&i<accountinfo.Phone.count-1) {
                    [numbers appendString:@"\n"];
                }
            }
        }else if(indexPath.row==1){
            title=@"邮箱";
            for (int i=0; i<accountinfo.Email.count; i++) {
                
                [numbers appendString:accountinfo.Email[i]];
                if (i>1&&i<accountinfo.Email.count-1) {
                    [numbers appendString:@"\n"];
                }
            }
            
            
        }
        [self showAlertResult:numbers withRoot:self.navigationController andTitle:title];
    }
    

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backup:(UIBarButtonItem *)sender {
       NSLog(@"clicked the back");
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
