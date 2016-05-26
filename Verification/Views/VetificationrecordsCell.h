//
//  VetificationrecordsCell.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface VetificationrecordsCell : UITableViewCell

@property (nonatomic ,assign) NSInteger type;
@property (nonatomic ,strong) BaseModel * model;

- (void)setContentForCell:(BaseModel *) model;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
