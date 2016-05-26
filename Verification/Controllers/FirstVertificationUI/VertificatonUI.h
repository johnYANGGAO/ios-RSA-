//
//  VertificatonUI.h
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VertificatonUI : UIViewController{
 
}
@property (nonatomic, weak) NSString *type;

@property (weak, nonatomic) IBOutlet UIScrollView *scroview;

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *idnumber;

@property (weak, nonatomic) IBOutlet UIView *seconedView;

@property (weak, nonatomic) IBOutlet UITextField *creditCard;

@property (weak, nonatomic) IBOutlet UITextField *cellphone;

- (IBAction)backItem:(UIButton *)sender;

- (IBAction)startCheck:(UIButton *)sender;


@end
