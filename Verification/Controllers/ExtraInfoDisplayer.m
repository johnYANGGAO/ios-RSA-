//
//  ExtraInfoDisplayer.m
//  Verification
//
//  Created by john's mac　　　　 on 6/22/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "ExtraInfoDisplayer.h"

@interface ExtraInfoDisplayer (){

}
@property (weak, nonatomic) IBOutlet UILabel *emaillabel;
@property (weak, nonatomic) IBOutlet UILabel *phonelabelfirst;
@property (weak, nonatomic) IBOutlet UILabel *phonelabelsecond;
- (IBAction)backnavbutton:(UIBarButtonItem *)sender;

@end


@implementation ExtraInfoDisplayer
@synthesize contactemail;
@synthesize contactphone;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initViews];

}

- (void)initViews{
    if(contactphone){
        self.phonelabelfirst.text=contactphone[0];
        if (contactphone.count>1) {
            self.phonelabelsecond.text=contactphone[1];
        }
    }else{
        self.phonelabelfirst.text=@"无";
        
    }
    if (contactemail) {
        self.emaillabel.text=contactemail;
    }else{
        
        self.emaillabel.text=@"无";
        
    }

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}



- (IBAction)backnavbutton:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
