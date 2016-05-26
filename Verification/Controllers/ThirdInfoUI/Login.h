//
//  Login.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)sure:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *background;
- (void)getConnection:(NSString *)url;
@end
