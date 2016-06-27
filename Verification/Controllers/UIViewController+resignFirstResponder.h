//
//  UIViewController+resignFirstResponder.h
//  Verification
//
//  Created by john's mac　　　　 on 6/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (resignFirstResponder)
/*
 此方法为当点击屏幕时，软键盘退出 
 */
- (void)setUpForDismissKeyboard;
/*
 仅弹出提示框
 */
- (void)showAlert:(NSString *)message withType:(NSInteger)type;
/*
 初始化提示进度
 */
- (void)initIndicator :(UIActivityIndicatorView *)indicator withBackground:(UIView *)view;
/*
 展示进度bar
 */
- (void)show:(Boolean)isShow target:(UIActivityIndicatorView *)indicator background:(UIView *)view;

@end
