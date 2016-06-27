//
//  FilterForRecords.h
//  Verification
//
//  Created by john's mac　　　　 on 6/16/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+resignFirstResponder.h"
@interface FilterForRecords : UIViewController<UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
//其他地方 用的是 nsstring 类型 ，这里尝试变换下
@property (nonatomic ,assign) NSInteger displaytype;//use it for hid or display views

@end
