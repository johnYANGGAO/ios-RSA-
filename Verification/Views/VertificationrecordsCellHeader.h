//
//  VertifiactionrecordsCellHeader.h
//  Verification
//
//  Created by john's mac　　　　 on 6/15/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VertificationrecordsCellHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titledate;
@property (weak, nonatomic) IBOutlet UILabel *titlecontent;
@property (weak, nonatomic) IBOutlet UILabel *titletype;

- (void)setTitles:(NSDictionary *)dic;
@end
