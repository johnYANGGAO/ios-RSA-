//
//  UITableViewController+Alert.h
//  Verification
//
//  Created by john's mac　　　　 on 6/16/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (Alert)

- (void)showAlertResult:(NSString *)message withRoot:(UINavigationController *)nav andTitle:(NSString *)title;

- (NSString *)solvedNilContent:(NSString *)content;

@end
