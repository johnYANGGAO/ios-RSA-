//
//  DetailInfoUIViewController.h
//  Verification
//
//  Created by john's mac　　　　 on 4/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoUIViewController : UIViewController{


}

@property (nonatomic, weak) NSString *infotype;
@property (nonatomic, strong) NSString *info;//接受传值

- (IBAction)back:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *idnumber;
@property (weak, nonatomic) IBOutlet UILabel *creditcard;
@property (weak, nonatomic) IBOutlet UILabel *cellphone;
@property (weak, nonatomic) IBOutlet UILabel *result;


@end
