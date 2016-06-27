//
//  UITableViewController+Alert.m
//  Verification
//
//  Created by john's mac　　　　 on 6/16/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "UITableViewController+Alert.h"

@implementation UITableViewController (Alert)

- (void)showAlertResult:(NSString *)message withRoot:(UINavigationController *)nav andTitle:(NSString *)title{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:action];
    [nav presentViewController:alertController animated:YES completion:nil];

}

- (NSString *)solvedNilContent:(NSString *)content{
    return content.length>0?content:@"无";
}


@end
