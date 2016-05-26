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
#import "RSA.h"
#include "iconv.h"
#import "DateUtil.h"
@interface Login ()

@end
static NSString *public_key=@"your public key";
@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)getConnection:(NSString *)url{
  
    NetConnection *conn=[NetConnection sharedManager];
    [conn requestGetData:nil netUrl:url successBlock:^(id responseBody) {
        NSLog(@"call back networking success %@",[conn dictionaryWithData:responseBody] );
        /**
         *保存信息 后跳转
         */
        [self presentMain];
        
    } failureBlock:^(NSString *error) {
         NSLog(@"call back error : %@",error);
        [self showAlert:error withType:1];
    }];
    

}
- (void)encodeDate{
   


}
- (IBAction)sure:(UIButton *)sender {
    
    if (self.account.text.length==0||self.password.text.length==0) {
        [self showAlert:@"请输入完整" withType:0];
        return;
    }
    
    NSString *url=nil;
    NSString *currentDateString = [DateUtil stringFromDate:@"yyyyMMddHHmmss"];
 
    NSLog(@"加密前的时间 是  %@",currentDateString);
   
    NSString *privkey = @"your private key";
    

   

    NSString *singn=[RSA encryptString:currentDateString publicKey:public_key];
    
    NSString *decode=[RSA decryptString:singn privateKey:privkey];
    url=[NSString stringWithFormat:@"your base http url/api/Users/Login?login=%@&pwd=%@&signature=%@",self.account.text,self.password.text.MD5,singn];
     NSLog(@"加密的时间 is %@ ",singn);
    
    NSLog(@"解密的时间 is %@",decode);
    [self getConnection:url];
    
}

- (void)presentMain{

    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainnavigation"];
    
    [self presentViewController:navController animated:YES completion:nil];

}
- (void)showAlert:(NSString *)message withType:(NSInteger)type{
    
    NSString *title=nil;
    if(type==0){
       title=@"提示";
    }else if(type==1){
       title=@"请求失败";
    }
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];

}
- (NSData *)cleanUTF8:(NSData *)data {
    // this function is from
    // http://stackoverflow.com/questions/3485190/nsstring-initwithdata-returns-null
    //
    //
    iconv_t cd = iconv_open("UTF-8", "UTF-8"); // convert to UTF-8 from UTF-8
    int one = 1;
    iconvctl(cd, ICONV_SET_DISCARD_ILSEQ, &one); // discard invalid characters
    size_t inbytesleft, outbytesleft;
    inbytesleft = outbytesleft = data.length;
    char *inbuf  = (char *)data.bytes;
    char *outbuf = malloc(sizeof(char) * data.length);
    char *outptr = outbuf;
    if (iconv(cd, &inbuf, &inbytesleft, &outptr, &outbytesleft)
        == (size_t)-1) {
        NSLog(@"this should not happen, seriously");
        return nil;
    }
    NSData *result = [NSData dataWithBytes:outbuf length:data.length - outbytesleft];
    iconv_close(cd);
    free(outbuf);
    return result;
}
@end
