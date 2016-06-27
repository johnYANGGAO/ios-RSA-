//
//  RecordsDetail.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "RecordsDetail.h"
#import "IDRecordsModel.h"
#import "DateUtil.h"
#import "NSString+MD5.h"

@interface RecordsDetail (){
    
    IDRecordsModel *idrecordsmodel;
}

@end

@implementation RecordsDetail

@synthesize model;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initViews];
   
}

- (void)initViews{

    
    idrecordsmodel=model;
    
    self.name.text= idrecordsmodel.UserName;
    self.projectName.text=idrecordsmodel.Module;
    self.creditCardNum.text=idrecordsmodel.BankCardNo.length>0?idrecordsmodel.BankCardNo.addStarNumber:@"无";
    self.IDcard.text=idrecordsmodel.IDCardNo.addStarNumber;
    self.date.text= [DateUtil formatDateString:idrecordsmodel.InsertDate withType:0];
    self.telephone.text=idrecordsmodel.TelephoneNo.length>0?idrecordsmodel.TelephoneNo:@"无";
    self.takefee.text=[NSString stringWithFormat:@"%@ 元",idrecordsmodel.Fee];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.section==2){
        if (indexPath.row==0) {
            
            //这里可以直接 弹出对话框提示   对应的结果 放在此处
            [self showAlertResult:idrecordsmodel.Result withRoot:self.navigationController andTitle:@"查询结果"];
        }
    }

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}


- (IBAction)quit:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
