//
//  VetificationrecordsCell.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDRecordsModel.h"
#import "BillRecordsModel.h"
@interface VetificationrecordsCell : UITableViewCell
@property (nonatomic ,strong) IDRecordsModel *idrecordsmodel;
@property (nonatomic ,strong) BillRecordsModel *billrecordsmodel;
- (void)setContentForCell:(id) model withType:(NSInteger)type;

@end
