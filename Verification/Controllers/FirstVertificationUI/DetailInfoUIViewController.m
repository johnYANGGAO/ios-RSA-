//
//  DetailInfoUIViewController.m
//  Verification
//
//  Created by john's mac　　　　 on 4/6/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "DetailInfoUIViewController.h"

@interface DetailInfoUIViewController ()

@end

@implementation DetailInfoUIViewController
@synthesize infotype;
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    NSLog(@"ihahah receiver  %@",infotype);
    
    if([infotype isEqual:@"0"]){
        self.secondView.hidden=YES;
    }else{
        self.secondView.hidden=NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
