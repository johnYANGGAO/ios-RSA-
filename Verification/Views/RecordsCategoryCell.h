//
//  RecordsCategoryCell.h
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordsCategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;

- (void)setContentForCategoryCell:(NSDictionary *)dic;
@end
