//
//  VertificationRecords.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VertificationRecords : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSMutableArray *datasource;
@property (nonatomic ,assign) NSInteger type;
- (IBAction)back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *VertificationRecordsTableView;

@end
