//
//  VertificatonUI.h
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+resignFirstResponder.h"
#import <SSKeychain/SSKeychain.h>

@interface VertificatonUI : UIViewController<UITextFieldDelegate>{
 
}
@property (nonatomic, strong) NSString * type;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *idnumber;

@property (weak, nonatomic) IBOutlet UITextField *creditCard;

@property (weak, nonatomic) IBOutlet UITextField *cellphone;
@property (weak, nonatomic) IBOutlet UIView *background;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)back:(UIBarButtonItem *)sender;

- (IBAction)startCheck:(UIButton *)sender;


@end
