//
//  AccountInfoDisplayer.h
//  Verification
//
//  Created by john's mac　　　　 on 6/22/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfoModel.h"
#import "UITableViewController+Alert.h"

@interface AccountInfoDisplayer : UITableViewController

@property (nonatomic ,strong) AccountInfoModel *accountinfo;

@end
