//
//  BaseCell.h
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flag;
@property (weak, nonatomic) IBOutlet UILabel *vertificationCategory;

- (void)setLabel:(NSDictionary *)dic;

@end
