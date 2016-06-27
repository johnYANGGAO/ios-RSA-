//
//  VertificationRecords.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+resignFirstResponder.h"
#import <SSKeychain/SSKeychain.h>
@interface VertificationRecords : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,assign) NSInteger type;//use it for url and  cell to display model 
@property (nonatomic ,strong) NSDictionary *dictionaryRequestBody;

- (IBAction)back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *VertificationRecordsTableView;

@end
