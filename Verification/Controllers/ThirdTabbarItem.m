//
//  ThirdTabbarItem.m
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "ThirdTabbarItem.h"

@implementation ThirdTabbarItem
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section=indexPath.section;
    switch (section) {
        case 0:
            NSLog(@"s0");
            if(indexPath.row==0){
                NSLog(@"s0 and row 0");
            }else if (indexPath.row==1){
                NSLog(@"s0 and row 1");
            }
            break;
        case 1:
            NSLog(@"s1");
            if(indexPath.row==0){
                NSLog(@"s1 and row 0");
            }
            break;
        case 2:
            NSLog(@"s2");
            if(indexPath.row==0){
                NSLog(@"s2 and row 0");
            }
            break;
            
        default:
            break;
    }
}

@end
