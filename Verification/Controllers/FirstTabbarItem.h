//
//  FirstTabbarItem.h
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  特注:此处不能继承UITableViewController
 */
@interface FirstTabbarItem : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray * datasource;

}

@property (weak, nonatomic) IBOutlet UITableView *FirstMainTabView;
@end
