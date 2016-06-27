//
//  Login.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "Login.h"
#import "NetConnection.h"
#import "NSString+MD5.h"
#import "RSA.h"//特注：同名情况不区分大小写
#import "DateUtil.h"
#import "MyKeyStore.h"
#import "Consts.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "MJExtension.h"
#import "UserInfoModel.h"
#import "FirmId.h"
#import "AccountInfoModel.h"
#import "BasicInfoModel.h"

@interface Login (){
    NSString *requestUrl;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *IndicatorBackground;

@property (weak, nonatomic) IBOutlet UIScrollView *loginscrollview;

@end


@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self setUpForDismissKeyboard];
    [self initIndicator:self.activityIndicator withBackground:self.IndicatorBackground];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)getConnection:(NSString *)url{
    
    [self show:YES target:self.activityIndicator background:self.IndicatorBackground];
    NetConnection *conn=[NetConnection sharedManager];
    
    [conn requestGetData:nil netUrl:url successBlock:^(id responseBody) {
        
        NSDictionary *dict=[conn dictionaryWithData:responseBody];
        NSLog(@"call back networking success %@",dict);
        NSString *result=nil;
        NSString *message =nil;
        if(dict){
            
            result=dict[@"Result"];
            unicodeToString(dict[@"Exception"], message);
            NSLog(@"the first exception is %@",message);
            if(result.intValue!=0){
                [self show:NO target:self.activityIndicator background:self.IndicatorBackground];
                [self showAlert:message withType:1];
            }else{
                //拿到id 后 再次请求
                FirmId *firm=[FirmId mj_objectWithKeyValues:dict[@"Data"]];
                NSLog(@"得到的 公司 ID 为%@",firm.CompanyID);
                NSLog(@"url没初始化为%@",requestUrl);
                [self initUrl:GetCompanyInfoUrl];
                NSLog(@"url拼接后为%@",requestUrl);
                NSDictionary *params = @ {@"ID" :firm.CompanyID };
                [self getBaseInfoQuester:requestUrl withParams:params];
                
            }
            
        }else{
            [self show:NO target:self.activityIndicator background:self.IndicatorBackground];            [self showAlert:@"解析错误" withType:0];
        }
        
    } failureBlock:^(NSString *error) {
        
        [self show:NO target:self.activityIndicator background:self.IndicatorBackground];
        NSLog(@"call back error : %@",error);
        [self showAlert:error withType:1];
    }];
    
    
}

//敏感账号 信息保存
- (void)storeSensiveDate:(NSString *)password name:(NSString *)logName{
    // Specify how the keychain items can be access
    // Do this in your -application:didFinishLaunchingWithOptions: callback
    [SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
    
    // Set an access token for later use
    [SSKeychain setPassword:password.MD5 forService:SSKey_service account:SSKey_key_name];
    //保存用户名
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:logName forKey:SSKey_key_name];
    
    [userDefaults synchronize];
    // Access that token when needed
    //    [SSKeychain passwordForService:SSKey_service account:logName];
    
    // Delete the token when appropriate (on sign out, perhaps)
    //    [SSKeychain deletePasswordForService:SSKey_service account:logName];
    
}
//用户基本信息 账户信息分别 保存
- (void)storeUserBaseInfo:(NSDictionary *) dicResponse{
    
    
    BasicInfoModel *basicmodel=[BasicInfoModel  mj_objectWithKeyValues:dicResponse[@"Basic"] ];
    
    AccountInfoModel *accoutmodel=[AccountInfoModel mj_objectWithKeyValues:dicResponse[@"Account"]];
    //获取文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *targetPath = [docPath stringByAppendingPathComponent:@"basic.plist"];
    
    //将自定义对象保存在指定路径下
    [NSKeyedArchiver archiveRootObject:basicmodel toFile:targetPath];
    NSLog(@"文件已储存");
    //==========================================
    
    NSString *docPath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *targetPath2 = [docPath2 stringByAppendingPathComponent:@"account.plist"];
    
    
    [NSKeyedArchiver archiveRootObject:accoutmodel toFile:targetPath2];
    NSLog(@"文件2已储存");
    
    
}
//ARC error if we do return a pointer
- (void)initUrl:(NSString *)appendurl{
    
    NSMutableString *ms = [[NSMutableString alloc] init];
    [ms appendString:BaseUrl];
    [ms appendString:appendurl];
    [ms appendString:@"=%@&pwd=%@&signature=%@"];
    
    NSString *currentDateString = [DateUtil stringFromDate:@"yyyyMMddHHmmss"];
    
    NSString *singn=[RSA encryptString:currentDateString publicKey:PublicKey_vertification];
    
    requestUrl=[NSString stringWithFormat:ms,self.account.text,self.password.text.MD5,singn];
    
}

- (IBAction)sure:(UIButton *)sender {
    
    [self.password resignFirstResponder];
    
    if (self.account.text.length==0||self.password.text.length==0) {
        [self showAlert:@"请输入完整" withType:0];
        return;
    }
    NSLog(@"url没初始化为%@",requestUrl);
    [self initUrl:LoginUrl ];
    NSLog(@"url拼接后为%@",requestUrl);
    [self storeSensiveDate:self.password.text  name:self.account.text];
    //    NSLog(@"解密的时间 is %@",decode);
    [self getConnection:requestUrl];
}


- (void)getBaseInfoQuester:(NSString *)url withParams:(id)params{
    
    NetConnection *conn=[NetConnection sharedManager];
    
    [conn requestPostData:params netUrl:url successBlock:^(id responseBody) {
        
        NSDictionary *dict=[conn dictionaryWithData:responseBody];
        NSLog(@"call back networking success %@",dict);
        NSString *result=nil;
        NSString *message =nil;
        if(dict){
            
            result=dict[@"Result"];
            unicodeToString(dict[@"Exception"], message);
            
            if(result.intValue!=0){
                
                [self showAlert:message withType:1];
                
            }else{
                NSDictionary *data=dict[@"Data"];
                
                [self storeUserBaseInfo:data];
                
                [self presentMain];
                
            }
            [self show:NO target:self.activityIndicator background:self.IndicatorBackground];
            
        }else{
            [self show:NO target:self.activityIndicator background:self.IndicatorBackground];
            
            [self showAlert:@"解析错误" withType:0];
        }
        
    } failureBlock:^(NSString *error) {
        
        [self show:NO target:self.activityIndicator background:self.IndicatorBackground];
        NSLog(@"call back error : %@",error);
        [self showAlert:error withType:1];
    }];
    
    
}
- (void)presentMain{
    
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainnavigation"];
    
    [self presentViewController:navController animated:YES completion:nil];
    
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


UITextField *activeField_login;

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField_login=textField;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField_login = nil;
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
    self.loginscrollview.contentInset = contentInsets;
    self.loginscrollview.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField_login.frame.origin) ) {
        [self.loginscrollview scrollRectToVisible:activeField_login.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.loginscrollview.contentInset = contentInsets;
    self.loginscrollview.scrollIndicatorInsets = contentInsets;
}


@end
