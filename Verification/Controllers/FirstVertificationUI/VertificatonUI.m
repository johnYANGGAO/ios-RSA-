//
//  VertificatonUI.m
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "VertificatonUI.h"
#import "DetailInfoUIViewController.h"
@interface VertificatonUI(){


}
@end

@implementation VertificatonUI
@synthesize type;

- (void)viewDidLoad{
    [super viewDidLoad];

    NSLog(@"receiver  %@",type);
    if([type isEqual:@"0"]){
        self.seconedView.hidden=YES;
    }else{
        self.seconedView.hidden=NO;
    }
}


- (IBAction)backItem:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startCheck:(UIButton *)sender {
    /**
     *  TODO get Connection
     */
    NSLog(@"start connect to net");
    
    DetailInfoUIViewController * ctrol=[self.storyboard instantiateViewControllerWithIdentifier:@"detailinfo"];
   

    ctrol.infotype=type;
     NSLog(@"send info  %@",ctrol.infotype);
    [self presentViewController:ctrol animated:YES completion:nil];

}


@end
