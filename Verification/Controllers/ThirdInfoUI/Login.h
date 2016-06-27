//
//  Login.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
//to avoid  duplicate interface definition for class sskeychain
#import <SSKeychain/SSKeychain.h>
#import "UIViewController+resignFirstResponder.h"

@interface Login : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)sure:(UIButton *)sender;

- (void)getConnection:(NSString *)url;

@end
