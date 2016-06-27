//
//  ThirdTabbarItem.m
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "ThirdTabbarItem.h"
#import "AccountInfoModel.h"
#import "BasicInfoModel.h"
#import "UserInfoModel.h"
#import "MyKeyStore.h"
#import "MJExtension.h"
#import "BasicInfoDisplayer.h"
#import "AccountInfoDisplayer.h"
#import "ExtraInfoDisplayer.h"

@interface ThirdTabbarItem(){
    
    UserInfoModel *usermodel;
    BasicInfoModel *basicmodel;
    AccountInfoModel *accountmodel;
    NSMutableArray *phone;
    NSString *email;
}

@end

@implementation ThirdTabbarItem
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getInfoFromBox];
   
}

- (void)getInfoFromBox{
    
    //获取文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *targetPath = [docPath stringByAppendingPathComponent:@"basic.plist"];
    NSString *accountTargetPath=[docPath stringByAppendingPathComponent:@"account.plist"];
   
    basicmodel  = [NSKeyedUnarchiver unarchiveObjectWithFile:targetPath];
    accountmodel=[NSKeyedUnarchiver unarchiveObjectWithFile:accountTargetPath];
   
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section=indexPath.section;
    switch (section) {
        case 0:
            NSLog(@"s0");
            if(indexPath.row==0){
              
                BasicInfoDisplayer *basicdisplay=[self.storyboard instantiateViewControllerWithIdentifier:@"basicinfodisplayer"];
                basicdisplay.basicinfo=basicmodel;
                UINavigationController *navBasicController = [[UINavigationController alloc]initWithRootViewController:basicdisplay];
                
                [self presentViewController:navBasicController animated:YES completion:nil];

                
            }else if (indexPath.row==1){
                AccountInfoDisplayer *accountdisplay=[self.storyboard instantiateViewControllerWithIdentifier:@"accountinfodisplayer"];
                accountdisplay.accountinfo=accountmodel;
                
                UINavigationController *navAccountController = [[UINavigationController alloc]initWithRootViewController:accountdisplay];
                
                [self presentViewController:navAccountController animated:YES completion:nil];
                
            }
            break;
        case 1:
            NSLog(@"s1");
            if(indexPath.row==0){
               
                ExtraInfoDisplayer *contactCtroller=[self.storyboard instantiateViewControllerWithIdentifier:@"contactdisplayer"];
                
                contactCtroller.contactemail=basicmodel.ContactEmail;
                contactCtroller.contactphone=basicmodel.ContactTel;
                
                UINavigationController *navContactController = [[UINavigationController alloc]initWithRootViewController:contactCtroller];
                
                
                [self presentViewController:navContactController animated:YES completion:nil];
            }
            break;
            
        default:
            break;
    }
}

@end
