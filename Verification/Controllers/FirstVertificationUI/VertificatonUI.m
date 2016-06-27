//
//  VertificatonUI.m
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "VertificatonUI.h"
#import "DetailInfoUIViewController.h"
#import "IDUtil.h"
#import "MJExtension.h"
#import "NetConnection.h"
#import "MyKeyStore.h"
#import "Consts.h"
#import "AESUtil.h"
#import "RSA.h"
#import "DateUtil.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"

@interface VertificatonUI(){
    Boolean isdown;
    NSString *constKey;
    NSString *requestUrl;
    NSDictionary *signparams;//sign params
    NSDictionary *requestVertificationBodyParams;//request body params
    UITextField *activeField;
}

@property (weak, nonatomic) IBOutlet UIStackView *stackviewmastor;


@end


@implementation VertificatonUI

@synthesize type;

- (void)viewDidLoad{
    [super viewDidLoad];
    //防止scrollview留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self setUpForDismissKeyboard];
    //    [self initdelegate];
    
    [self registerForKeyboardNotifications];

    [self initIndicator:self.indicator withBackground:self.background];
   
    NSLog(@"receiver  %@",type);
    [self getKey];
    UIView * firstView = self.stackviewmastor.arrangedSubviews[2];
    UIView * secondView = self.stackviewmastor.arrangedSubviews[3];
    
    if([type isEqualToString:@"0"]){
        
        [UIView animateWithDuration:0.02 animations:^{
            firstView.hidden = YES;
            secondView.hidden=YES;
        }];

    }else{
        [UIView animateWithDuration:0.02 animations:^{
            firstView.hidden = NO;
            secondView.hidden=NO;
        }];
    }
}

- (IBAction)back:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)startCheck:(UIButton *)sender {
    
    if([self inputAdjust:type]){
        //初始化参数
        [self initRequestParames];
        //start request
        [self getConnection:requestUrl withParams:requestVertificationBodyParams];
    }
    
}


- (void)getKey{
   
  constKey=[AESUtil generateAESKey];
  NSLog(@"aes key is   %@",constKey);

}

- (void)getSignParamsTime:(NSString *)time withAESkey:(NSString *)aeskey{

   signparams= [NSDictionary dictionaryWithObjectsAndKeys:
                           time,@"time",
                           aeskey,@"aes",nil];


}

- (void)initUrl:(NSString *)appendurl{
    
    NSMutableString *ms = [[NSMutableString alloc] init];
    [ms appendString:BaseUrl];
    [ms appendString:appendurl];
    [ms appendString:@"=%@&pwd=%@&signature=%@"];
    
    NSString *currentDateString = [DateUtil stringFromDate:@"yyyyMMddHHmmss"];
    
    [self getSignParamsTime:currentDateString withAESkey:constKey];
    
   
    NSString * jsonstr=[[NetConnection sharedManager] dictionaryToJsonStr:signparams];
    NSString *singn=[RSA encryptString:jsonstr publicKey:PublicKey_vertification];
    
    NSLog(@"sign before rsa is %@",jsonstr);
    NSLog(@"sign after rsa is %@",singn);
    
    //Test
    NSString *uncovered=[RSA decryptString:singn privateKey:PrivateKey_vertification];
    NSLog(@"uncovered is %@",uncovered);
    
    
    
    NSString *loginName= [[NSUserDefaults standardUserDefaults] objectForKey:SSKey_key_name];
    
    NSString *passoword = [SSKeychain passwordForService:SSKey_service account:SSKey_key_name];
    
    requestUrl=[NSString stringWithFormat:ms,loginName,passoword,singn];
    
    NSLog(@"requestUrl is %@",requestUrl);
    
}


- (void)initRequestParames{
    
    if([type isEqualToString:@"0"]){
        [self initUrl:VertificationByID];
        requestVertificationBodyParams=[NSDictionary dictionaryWithObjectsAndKeys:
                           @"Name",[AESUtil AESencrypt:self.name.text withKey:constKey],
                           @"IDCardNo",[AESUtil AESencrypt:self.idnumber.text withKey:constKey],nil];
//        [AESUtil AESdecrypt:[AESUtil AESencrypt:self.idnumber.text withKey:constKey] withKey:constKey];
//        [AESUtil AESdecrypt:[AESUtil AESencrypt:self.name.text withKey:constKey] withKey:constKey];
    }else{
        [self initUrl:VertificationByBank];
        requestVertificationBodyParams=[NSDictionary dictionaryWithObjectsAndKeys:
                           @"UserName",[AESUtil AESencrypt:self.name.text withKey:constKey],
                           @"IDCardNo",[AESUtil AESencrypt:self.idnumber.text withKey:constKey],
                           @"IDCardType",@"01",
                           @"CardNo",[AESUtil AESencrypt:self.creditCard.text withKey:constKey],
                           @"TelephoneNo",[AESUtil AESencrypt:self.cellphone.text withKey:constKey],
                           nil];
    }
    NSLog(@"requestBodyParams is %@",requestVertificationBodyParams);

}
/*
 特注 ios 中 参数名 即使是形参 也不能和其他同名 否则get set 混淆
 */
- (void)getConnection:(NSString *)url withParams:(id)bodyparams{
    
    [self show:YES target:self.indicator background:self.background];
    NetConnection *conn=[NetConnection sharedManager];
    
    [conn requestPostData:bodyparams netUrl:url successBlock:^(id responseBody) {
        
        NSDictionary *dict=[conn dictionaryWithData:responseBody];
        NSLog(@"call back networking success %@",dict);
        NSString *result=nil;
        NSString *message =nil;
        if(dict){
            
            result=dict[@"Result"];
            unicodeToString(dict[@"Exception"], message);
            NSLog(@"the first exception is %@",message);
            if(result.intValue!=0){
                
                [self show:NO target:self.indicator background:self.background];
                [self showAlert:message withType:1];
                
            }else{
              /*{"Code":"1100","Data":"结果一致","TransactionNo":"1b6c99d72f6c4302b544e3d1323f6495","ExtInfo":" ","IsCharging":true,"Result":0,"Exception":"操作成功"}*/
//                NSString *transno=[NSString stringWithFormat:@"\n交易码: %@",dict[@"TransactionNo"]];
//                NSString *ms=[dict[@"Data"] stringByAppendingString:transno];
//                NSLog(@"data result is %@ ",ms);
//                [self presentResult:ms];
                //简洁通知处理结果显示
                [self show:NO target:self.indicator background:self.background];
                [self showAlert:dict[@"Data"] withType:2];
            }
            
        }else{
            [self show:NO target:self.indicator background:self.background];
            [self showAlert:@"解析错误" withType:0];
        }
        
    } failureBlock:^(NSString *error) {
        
        [self show:NO target:self.indicator background:self.background];
        NSLog(@"call back error : %@",error);
        [self showAlert:error withType:1];
    }];
    
    
}

//请求成功后跳转 显示页面  备用
- (void)presentResult:(NSString *)dicinfo{
    
        DetailInfoUIViewController * ctrol=[self.storyboard instantiateViewControllerWithIdentifier:@"detailinfo"];
    
        ctrol.infotype=type;
        ctrol.info=dicinfo;
        NSLog(@"send info type  %@",type);
        NSLog(@"send info  %@",dicinfo);
    
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:ctrol];
    
    
        [self presentViewController:navController animated:YES completion:nil];
    
}


//NO 和 false 的区别 就是 对应的 Boolean 和 boolean 区别
- (Boolean)inputAdjust:(NSString *)whichtype{
    
    
    if(![type isEqualToString:@"0"]){// add sec's view's subview
        if (self.creditCard.text.length<=0) {
            [self showAlert:@"银行卡号不能为空 !" withType:0];
            return NO;
        }
        
    }
    
    if (self.name.text.length<=0) {
        [self showAlert:@"姓名不能为空 !" withType:0];//0 for note 1 for request error
        return NO;
    }
    if (self.idnumber.text.length<=0) {
        [self showAlert:@"身份证号不能为空 !" withType:0];
        return NO;
    }
    if ([IDUtil isIdInputRight:self.idnumber.text]) {
        return YES;
        
    }else{
        
        [self showAlert:@"请正确输入身份证号 !" withType:0];
        return NO;
    }
   
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField=textField;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollview.contentInset = contentInsets;
    self.scrollview.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollview scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollview.contentInset = contentInsets;
    self.scrollview.scrollIndicatorInsets = contentInsets;
}

@end
