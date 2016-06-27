//
//  FilterForRecords.m
//  Verification
//
//  Created by john's mac　　　　 on 6/16/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "FilterForRecords.h"
#import "VertificationRecords.h"


@interface FilterForRecords(){
    
    UITextField *activefield;
    UIView *pickProjectView;
    UIView *pickDateView;
    UIView *pickViews;
    NSArray *textPickerData;
    Boolean isstart;
    UIPickerView *textPicker;
    UIDatePicker *datePicker;
    NSInteger moduletype;
    Boolean iskeyboardon;
    NSString *notificationLabelPressed;
}

@property (weak, nonatomic) IBOutlet UIStackView *ControllerViewStackViewMastor;
@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollview;

@property (weak, nonatomic) IBOutlet UITextField *loginname;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *IDCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *projectName;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;


- (IBAction)backButton:(UIBarButtonItem *)sender;
- (IBAction)sureButton:(UIBarButtonItem *)sender;
//替代uibutton（不会随uistackview 消失？？？）
//点击事件用手势 由于变换颜色的问题 所以弃用uigesturerecongnizer
@property (weak, nonatomic) IBOutlet UILabel *takepickture;


@end


@implementation FilterForRecords

@synthesize displaytype;

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    textPickerData=@[@"全部",@"银行卡", @"身份证"];
   
    NSLog(@"Get  secondTabbarItem's value is %ld", displaytype);
    [self setUpForDismissKeyboard];
    [self registerForKeyboardNotifications];
    [self displayView];
   
    [self initDatePicker];
    [self initTextPick];
    [self initTextpictureAction];
    
}

- (void)initTextpictureAction{
    
    UILongPressGestureRecognizer *longtap=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(changeTakePictureLabelColor:)];
     longtap.minimumPressDuration = 0.01f;
    
    [self.takepickture addGestureRecognizer:longtap];
}
#pragma mark UILabel'Gesture
- (void)changeTakePictureLabelColor:(UILongPressGestureRecognizer *)gesture{

      CGPoint locationPoint = [gesture locationInView:self.takepickture];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        self.takepickture.highlighted = YES;
    }
    
    if(gesture.state == UIGestureRecognizerStateChanged)
    {
        if (locationPoint.x <= self.takepickture.bounds.size.width && locationPoint.x >= 0 &&
            locationPoint.y <= self.takepickture.bounds.size.height && locationPoint.y >= 0)
        {
            self.takepickture.highlighted = YES;
        }
        else
        {
            self.takepickture.highlighted = NO;
        }
    }
    //add action optional
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        
        if (locationPoint.x <= self.takepickture.bounds.size.width && locationPoint.x >= 0 &&
            locationPoint.y <= self.takepickture.bounds.size.height && locationPoint.y >= 0)
        {
            [self OnTapTakePictureLabel];
        }
        
        self.takepickture.highlighted = NO;
        
    }

}

- (void)OnTapTakePictureLabel{
    
    [self showAlert:@"此功能 暂不支持" withType:0];

}
- (IBAction)backButton:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureButton:(UIBarButtonItem *)sender {
   
    NSDictionary *dic=nil;//没有采用可变是为了能直接附值 节省资源
    if (iskeyboardon) {
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.view endEditing:YES];
            NSLog(@"click is on keyboard is %d",iskeyboardon);

        }];
        
    }else{
        
       if([self isCompleted]){
        
             if(displaytype==0){
              
                dic=@{@"Login": self.loginname.text,@"UserName": self.username.text,@"CardNo":self.IDCardNumber.text,@"ModuleType": [NSString stringWithFormat:@"%ld",moduletype],@"StartDate": self.startTime.text,@"EndDate":self.endTime.text,@"Take":[NSString stringWithFormat:@"%d",20]};

             }else{
            
                dic=@{@"StartDate": self.startTime.text,@"EndDate":self.endTime.text,@"Take":[NSString stringWithFormat:@"%d",20]};
             
             }
             NSLog(@"dic is %@",dic);
            [self presentToVertificationRecords:dic];
        }else{
   
            [self showAlert:@"请确保时间区段完全" withType:0];
    }
  }
}



- (void)displayView{
    
     UIView *firstView=self.ControllerViewStackViewMastor.arrangedSubviews[0];
     UIView *secondView=self.ControllerViewStackViewMastor.arrangedSubviews[1];
     UIView *thirdView=self.ControllerViewStackViewMastor.arrangedSubviews[2];
     UIView *fourthView=self.ControllerViewStackViewMastor.arrangedSubviews[3];
    
    if(displaytype==0){
        
        [UIView animateWithDuration:0.02 animations:^{
            firstView.hidden=NO;
            secondView.hidden=NO;
            thirdView.hidden=NO;
            fourthView.hidden=NO;
        }];
    
    }else if(displaytype==1){
    
      [UIView animateWithDuration:0.02 animations:^{
          firstView.hidden=YES;
          secondView.hidden=YES;
          thirdView.hidden=YES;
          fourthView.hidden=YES;
      }];
    }
}

- (void)initTextPick{

    textPicker=[[UIPickerView alloc]init];
    textPicker.backgroundColor=[UIColor whiteColor];
    textPicker.delegate=self;
    textPicker.dataSource=self;


}
- (void)initDatePicker{
    datePicker=[[UIDatePicker alloc]init];
    datePicker.backgroundColor=[UIColor whiteColor];
    [datePicker addTarget:self
                          action:@selector(choseDateValue:)
                forControlEvents:UIControlEventValueChanged];

}

- (void)choseDateValue:(UIDatePicker *)sender{
    
    NSDate *myDate = sender.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //TODO 转换要显示的格式 备注 ：当要 作为参数 时 要改为 .net 的时间格式 （应后台要求限制 （没有统一格式））
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *showdatestring = [dateFormat stringFromDate:myDate];
    
    if (isstart) {
        self.startTime.text=showdatestring;
    }else{
        self.endTime.text=showdatestring;
    }

}



- (void)presentToVertificationRecords :(NSDictionary *)valueparams{

    VertificationRecords *vrcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"VertificationRecords"];
    vrcontroller.type=self.displaytype;
    vrcontroller.dictionaryRequestBody=valueparams;
    
    [self presentViewController:vrcontroller animated:YES completion:nil];

}

- (Boolean)isCompleted{
    
    if(self.startTime.text.length==0||self.endTime.text.length==0){
        return NO;
    }
    
    return YES;
}



#pragma mark UIPickerView delegate and source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"hello get title is %@",textPickerData[row]);
    self.projectName.text=textPickerData[row];
    moduletype=row;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return textPickerData.count;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{


    return textPickerData[row];
}




#pragma mark uitextfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activefield=textField;
    if(self.startTime==textField){
        self.startTime.inputView=datePicker;
        isstart=YES;
    
    }else if(self.endTime==textField){
        self.endTime.inputView=datePicker;
        isstart=NO;
    }else if(self.projectName==textField){
    
        self.projectName.inputView=textPicker;
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    activefield = nil;
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    iskeyboardon=YES;
    NSLog(@"text keyboard wh is on keyboard is %d",iskeyboardon);

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.filterScrollview.contentInset = contentInsets;
    self.filterScrollview.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activefield.frame.origin) ) {
        [self.filterScrollview scrollRectToVisible:activefield.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    iskeyboardon=NO;
     NSLog(@"is on keyboard is %d",iskeyboardon);
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.filterScrollview.contentInset = contentInsets;
    self.filterScrollview.scrollIndicatorInsets = contentInsets;
}

@end

