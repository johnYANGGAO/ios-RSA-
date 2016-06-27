//
//  BasicInfoDisplayer.m
//  Verification
//
//  Created by john's mac　　　　 on 6/22/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "BasicInfoDisplayer.h"


@interface BasicInfoDisplayer(){


}

@property (weak, nonatomic) IBOutlet UILabel *legalperson;
@property (weak, nonatomic) IBOutlet UILabel *companyname;
@property (weak, nonatomic) IBOutlet UILabel *provice;
@property (weak, nonatomic) IBOutlet UILabel *legalpersonphone;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *legalpersonTel;
- (IBAction)backup:(UIBarButtonItem *)sender;

@end

@implementation BasicInfoDisplayer
@synthesize basicinfo;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initViews];
    
}

- (void)initViews{
    
    self.legalperson.text=[self solvedNilContent:basicinfo.LegalPerson];
    self.companyname.text=[self solvedNilContent:basicinfo.CompanyName];
    self.provice.text=[self solvedNilContent:basicinfo.Province];
    self.city.text=[self solvedNilContent:basicinfo.City];
    self.legalpersonTel.text=[self solvedNilContent:basicinfo.LegalTel];
    self.legalpersonphone.text=[self solvedNilContent:basicinfo.LegalMobile];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section==1) {
            if (indexPath.row==0) {
               [self showAlertResult:[self solvedNilContent:basicinfo.Address] withRoot:self.navigationController andTitle:@"详细地址"];
                NSLog(@"clicked the address button");
            }
    }

}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backup:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
