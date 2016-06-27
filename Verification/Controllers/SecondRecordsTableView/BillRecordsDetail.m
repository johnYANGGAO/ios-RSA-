//
//  BillRecordsDetail.m
//  Verification
//
//  Created by john's mac　　　　 on 6/22/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "BillRecordsDetail.h"
#import "BillRecordsModel.h"
#import "DateUtil.h"


@interface BillRecordsDetail(){
    BillRecordsModel *billmodel;
}
@property (weak, nonatomic) IBOutlet UILabel *IDsuccess;
@property (weak, nonatomic) IBOutlet UILabel *IDchecktimes;
@property (weak, nonatomic) IBOutlet UILabel *IDspentfee;
@property (weak, nonatomic) IBOutlet UILabel *Banksuccess;
@property (weak, nonatomic) IBOutlet UILabel *Bankchecktimes;
@property (weak, nonatomic) IBOutlet UILabel *Bankspentfee;
@property (weak, nonatomic) IBOutlet UILabel *viewdate;
@property (weak, nonatomic) IBOutlet UILabel *totalfeepresent;

- (IBAction)backup:(UIBarButtonItem *)sender;

@end

@implementation BillRecordsDetail
@synthesize model;
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initViews];

}

- (void)initViews{
    billmodel=model;
    NSLog(@"bill model time is %@",billmodel.ViewDate);
    self.IDsuccess.text=[NSString stringWithFormat:@"%d" ,billmodel.VIDCardSucceed];
    self.Banksuccess.text=[NSString stringWithFormat:@"%d" ,billmodel.VBankSucceed];
  
    self.IDchecktimes.text=[NSString stringWithFormat:@"%d" ,billmodel.VIDCardCount];
    self.Bankchecktimes.text=[NSString stringWithFormat:@"%d" ,billmodel.VBankCount];
    self.IDspentfee.text=[NSString stringWithFormat:@"%d" ,billmodel.VIDCardCharging];
    self.Bankspentfee.text=[NSString stringWithFormat:@"%d" ,billmodel.VBankCharging];
    self.totalfeepresent.text=[NSString stringWithFormat:@"%@ 元" ,billmodel.TotalMoney];
    self.viewdate.text=[DateUtil formatDateString:billmodel.ViewDate withType:0];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//   }
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}


- (IBAction)backup:(UIBarButtonItem *)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}
@end

