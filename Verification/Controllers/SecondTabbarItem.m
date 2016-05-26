//
//  SecondTabbarItem.m
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "SecondTabbarItem.h"
#import "RecordsCategoryCell.h"
#import "VertificationRecords.h"
@implementation SecondTabbarItem

-(void)viewDidLoad{
    
    [super viewDidLoad];

    [self initDataSource];
}

- (void)initDataSource{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"recordsCategory" ofType:@"plist"];
    
    datasource=[[NSMutableArray alloc] initWithContentsOfFile:path];
    
    self.recordsCategoryTableView.delegate=self;
    self.recordsCategoryTableView.dataSource=self;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"recordsCategory";
    
    RecordsCategoryCell * recordscategorycell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSDictionary *dataDic = datasource[indexPath.row];
    
    [recordscategorycell setContentForCategoryCell:dataDic];
    
    
    return recordscategorycell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VertificationRecords *vrcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"VertificationRecords"];
    vrcontroller.type=indexPath.row;
    [self presentViewController:vrcontroller animated:YES completion:nil];
}
@end
