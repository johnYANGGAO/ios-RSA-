//
//  SecondTabbarItem.h
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTabbarItem : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *datasource;
}
@property (weak, nonatomic) IBOutlet UITableView *recordsCategoryTableView;

@end
