//
//  DetailInfoUIViewController.m
//  Verification
//
//  Created by john's mac　　　　 on 4/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "DetailInfoUIViewController.h"

@interface DetailInfoUIViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *stackviewmastor;

@end

@implementation DetailInfoUIViewController

@synthesize infotype;
@synthesize info;

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    NSLog(@"type receiver  %@",infotype);
    NSLog(@"info receiver  %@",info);
    UIView * firstView = self.stackviewmastor.arrangedSubviews[2];
    UIView * secondView = self.stackviewmastor.arrangedSubviews[3];

    if([infotype isEqual:@"0"]){
        [UIView animateWithDuration:0.02 animations:^{
            firstView.hidden = YES;
            secondView.hidden=YES;
        }];

    }else{
        [UIView animateWithDuration:0.02 animations:^{
            firstView.hidden = NO;
            secondView.hidden=NO;
        }];

    }
    if (info) {
         self.result.text=info;
    }else{
         self.result.text=@"未得到结果,请返回再次验证！";
    }
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


@end
