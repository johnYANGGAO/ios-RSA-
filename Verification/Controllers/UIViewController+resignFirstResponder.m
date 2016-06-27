//
//  UIViewController+resignFirstResponder.m
//  Verification
//
//  Created by john's mac　　　　 on 6/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "UIViewController+resignFirstResponder.h"

@implementation UIViewController (resignFirstResponder)


- (void)setUpForDismissKeyboard{

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    //当键盘起来注册监听
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    //当键盘消失移除监听
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里可输入的subview的first responder都resign掉
    [self.view endEditing:YES];
}

- (void)showAlert:(NSString *)message withType:(NSInteger)type{
    
    NSString *title=nil;
    if(type==0){
        title=@"提示";
    }else if(type==1){
        title=@"请求失败";
    }else if(type==2){
     title=@"验证结果";
    }
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)initIndicator :(UIActivityIndicatorView *)indicator withBackground:(UIView *)background{

        background.hidden=YES;
        indicator.hidden=YES;
        indicator.hidesWhenStopped=YES;

}

- (void)show:(Boolean)isShow target:(UIActivityIndicatorView *)indicator background:(UIView *)background{

    if(isShow){
        background.hidden=NO;
        indicator.hidden=NO;
        [indicator startAnimating];
    }else{
        [indicator stopAnimating];
        background.hidden=YES;
    }

}

@end
