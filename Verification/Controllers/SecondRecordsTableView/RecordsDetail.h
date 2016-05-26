//
//  RecordsDetail.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
/**
 *  对于静态的 无需 cell重用 适合不满屏或少屏的 tableview
 */
@interface RecordsDetail : UITableViewController

@property (nonatomic, strong) BaseModel *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *creditCardNum;
@property (weak, nonatomic) IBOutlet UILabel *IpAdress;

- (IBAction)quit:(UIBarButtonItem *)sender;

@end
