//
//  VertificationRecords.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "VertificationRecords.h"
#import "VetificationrecordsCell.h"
#import "MJRefresh.h"
#import "BaseModel.h"
#import "Consts.h"
#import "RecordsDetail.h"
@interface VertificationRecords (){
    NSInteger page;
}

@end

@implementation VertificationRecords

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initForBeging];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self initForBeging];
}
- (void)initForBeging{
    page=1;
    self.datasource=[NSMutableArray arrayWithCapacity:0];
    [self simulatorData];
    self.VertificationRecordsTableView.delegate=self;
    self.VertificationRecordsTableView.dataSource=self;
    [self getHeader];
    [self getFooter];
    
}
/**
 *  模拟数据
 */
- (void)simulatorData{
    
    for (int count=0;count<15;count++){
        BaseModel *model=[[BaseModel alloc]init];
        if(count%2==0){
            model.name=@"王强";
             model.project=@"账单";
        }else{
            model.name=@"张小小";
             model.project=@"身份查询";
        }
        model.category=@"手机余额";
        model.time=@"2014－6-6";
        model.money=@"$5";
        model.result=@"此状态 正常 ，请放心使用 ";
        model.ipAdress=@"196.168.0.10";
        model.creditCard=@"622 848987654321";
        [self.datasource addObject:model];
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *infoAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"详情" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        /**
         *  查看详情
         */
        RecordsDetail *ctrol=[self.storyboard instantiateViewControllerWithIdentifier:@"recordsdetailtableview"];
        ctrol.model=[self.datasource objectAtIndex:indexPath.row];
        //storyboard视图层加载不上
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:ctrol];
    
        [self presentViewController:navController animated:YES completion:nil];
        
        tableView.editing = NO;
        
    }];
    
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            [self.datasource removeObjectAtIndex:indexPath.row];
    
            // refresh
            [self.VertificationRecordsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            // 不需要主动退出编辑模式，上面更新view的操作完成后就会自动退出编辑模式
        }];
    
    return @[infoAction,deleteAction];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *identify=@"vertificationrecordscell";
    VetificationrecordsCell * cell=[tableView dequeueReusableCellWithIdentifier:identify];
    
    if(cell==nil){
        cell= [[VetificationrecordsCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identify];
    }
    BaseModel * model= _datasource[indexPath.row];
    if (self.type==0) {
        cell.type=0;
        [cell setContentForCell:model];
        
        
    }else if(self.type==1){
        cell.type=1;
        [cell setContentForCell:model];
        
        
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.type==0) {
        //时间 姓名 项目
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
        headerView.backgroundColor=navigationBarColor;
        
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screen_width/3,headerView.frame.size.height)];
        date.textAlignment = NSTextAlignmentCenter;
        date.textColor = [UIColor whiteColor];
        date.font = [UIFont systemFontOfSize:15];
        date.text = @"时间";
        
        [headerView addSubview:date];
        
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(date.frame),0, screen_width/3,headerView.frame.size.height)];
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = [UIColor whiteColor];
        name.font = [UIFont systemFontOfSize:15];
        name.text = @"姓名";
        
        [headerView addSubview:name];
        
        UILabel *project = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame),0, screen_width/3,headerView.frame.size.height)];
        project.textAlignment = NSTextAlignmentCenter;
        project.textColor = [UIColor whiteColor];
        project.font = [UIFont systemFontOfSize:15];
        project.text = @"项目";
        
        [headerView addSubview:project];
        
        return headerView;
        
    }else if(self.type==1){
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
        headerView.backgroundColor=navigationBarColor;
        
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screen_width/3,headerView.frame.size.height)];
        date.textAlignment = NSTextAlignmentCenter;
        date.textColor = [UIColor whiteColor];
        date.font = [UIFont systemFontOfSize:15];
        date.text = @"时间";
        
        [headerView addSubview:date];
        
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(date.frame)+10,0, screen_width/3,headerView.frame.size.height)];
        money.textAlignment = NSTextAlignmentCenter;
        money.textColor = [UIColor whiteColor];
        money.font = [UIFont systemFontOfSize:15];
        money.text = @"金额";
        
        [headerView addSubview:money];
        
        UILabel *category = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(money.frame)+10,0, screen_width/3,headerView.frame.size.height)];
        category.textAlignment = NSTextAlignmentCenter;
        category.textColor = [UIColor whiteColor];
        category.font = [UIFont systemFontOfSize:15];
        category.text = @"项目";
        [headerView addSubview:category];
        return headerView;
    }
    return nil;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return 55;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [_datasource count];
    
}



- (void)getHeader{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadfreshdata)];
    
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    
    UIImage *image = [UIImage imageNamed:@"icon_refresh_1"];
    [idleImages addObject:image];
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    /**
     *  it will get nil if no name of image macthed .
     */
    UIImage *image1 = [UIImage imageNamed:@"icon_refresh_2"];
    [pullingImages addObject:image1];
    UIImage *image2 = [UIImage imageNamed:@"icon_refresh_3"];
    [pullingImages addObject:image2];
    
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:pullingImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.VertificationRecordsTableView.mj_header = header;
    
}

- (void)loadfreshdata{
    
    
}
- (void)loadMoreData{
    page++;
    
    
}
- (void)getFooter{
    
    MJRefreshAutoNormalFooter *footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"请稍后..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据啦 " forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    self.VertificationRecordsTableView.mj_footer=footer;
    
}
- (void)finishedFreshing{
    if ([self.VertificationRecordsTableView.mj_header isRefreshing]) {
        [self.VertificationRecordsTableView.mj_header endRefreshing];
    }
    if ([self.VertificationRecordsTableView.mj_footer isRefreshing]) {
        [self.VertificationRecordsTableView.mj_footer endRefreshing];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
