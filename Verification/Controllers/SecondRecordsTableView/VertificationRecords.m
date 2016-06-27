//
//  VertificationRecords.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "VertificationRecords.h"
#import "VetificationrecordsCell.h"
#import "VertificationrecordsCellHeader.h"
#import "MJRefresh.h"
#import "IDRecordsModel.h"
#import "BillRecordsModel.h"
#import "Consts.h"
#import "RecordsDetail.h"
#import "MJExtension.h"
#import "NetConnection.h"
#import "MyKeyStore.h"
#import "RSA.h"
#import "DateUtil.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "IDRecordsModelData.h"
#import "BillRecordsModelData.h"
#import "BillRecordsDetail.h"
@interface VertificationRecords (){
    
    NSString *page;
    NSString *requestRecordsUrl;
    NSDictionary *requestRecordsBodyParams;
    NSMutableArray *datasource;
    IDRecordsModelData *modeldata;
    BillRecordsModelData *billdata;
    int divider;
}
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorBackground;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VertificationRecords
//need to add other's params
@synthesize dictionaryRequestBody;
@synthesize type;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"get the body parames from filter is %@",dictionaryRequestBody);
    [self initForBeging];
    
    [self initIndicator:self.activityIndicator withBackground:self.activityIndicatorBackground];
    [self startToGetNetData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initForBeging{
    
    page=@"0";
    //must be  initialized  or  setting object does't work
    datasource=[[NSMutableArray alloc]initWithCapacity:20];
    self.VertificationRecordsTableView.delegate=self;
    self.VertificationRecordsTableView.dataSource=self;
    [self getHeader];
    
}


- (void)initparams:(NSString *)appendurl{

    NSMutableString *ms = [[NSMutableString alloc] init];
    [ms appendString:BaseUrl];
    [ms appendString:appendurl];
    [ms appendString:@"=%@&pwd=%@&signature=%@"];
    
    
    NSString *currentDateString = [DateUtil stringFromDate:@"yyyyMMddHHmmss"];
    NSString *singn=[RSA encryptString:currentDateString publicKey:PublicKey_vertification];

    NSString *loginName= [[NSUserDefaults standardUserDefaults] objectForKey:SSKey_key_name];
    
    NSString *passoword = [SSKeychain passwordForService:SSKey_service account:SSKey_key_name];
    
    requestRecordsUrl=[NSString stringWithFormat:ms,loginName,passoword,singn];
    
    NSLog(@"requestUrl is %@",requestRecordsUrl);

}

- (void)getConnectNet:(NSString *)url withParams:(NSDictionary *)body{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:body];
    [dic setValue:page forKey:@"Skip"];
    
    NSLog(@"params added is %@ and requested url is %@",dic,requestRecordsUrl);
    
    [self show:YES target:self.activityIndicator background:self.activityIndicatorBackground];
    
    NetConnection *conn=[NetConnection sharedManager];
    
    [conn requestPostData:dic netUrl:url successBlock:^(id responseBody) {
        
        NSDictionary *dict=[conn dictionaryWithData:responseBody];
        NSLog(@"call back networking success %@",dict);
        NSString *result=nil;
        NSString *message =nil;
        if(dict){
            
            [self show:NO target:self.activityIndicator background:self.activityIndicatorBackground];
            result=dict[@"Result"];
            [self endRefresh];
            unicodeToString(dict[@"Exception"], message);
            NSLog(@"the  exception is %@",message);
            if(result.intValue!=0){
                
                [self showAlert:message withType:1];
                
            }else{
                
                if (page.intValue==0&&datasource.count>0) {
                   
                    [datasource removeAllObjects];
                  
                }
                
                //将dict转成 model
                if (type==0) {
                   
                     modeldata=[IDRecordsModelData mj_objectWithKeyValues:dict];
                     if(modeldata.Data.count>0){
                         for(int i=0;i<modeldata.Data.count;i++){
                             
                             IDRecordsModel *idrm=[IDRecordsModel mj_objectWithKeyValues:modeldata.Data[i]];
                             
                             [datasource addObject:idrm];
                         }
                         if( datasource.count>0){
                             [self getFooter];
                         }

                         [self.VertificationRecordsTableView reloadData];
                        
                     }else {
                         [self showAlert:@"已无相关数据" withType:0];
                         if (self.VertificationRecordsTableView.mj_footer) {
                             if (MJRefreshStateIdle==self.VertificationRecordsTableView.mj_footer.state) {
                                 self.VertificationRecordsTableView.mj_footer.state=MJRefreshStateNoMoreData;
                             }
                         }
                     }
                    
                }else if(type==1){
                    
                    billdata=[BillRecordsModelData mj_objectWithKeyValues:dict];
                    
                    if(billdata.Data.count>0){
                        
                        for (int j=0;j< billdata.Data.count;j++) {
                            BillRecordsModel *brm=[BillRecordsModel mj_objectWithKeyValues:billdata.Data[j]];
                            [datasource addObject:brm];
                        }
                        if( datasource.count>0){
                            [self getFooter];
                        }
                     [self.VertificationRecordsTableView reloadData];
                    }else {
                        [self showAlert:@"已无相关数据" withType:0];
                        if (self.VertificationRecordsTableView.mj_footer) {
                            if (MJRefreshStateIdle==self.VertificationRecordsTableView.mj_footer.state) {
                                self.VertificationRecordsTableView.mj_footer.state=MJRefreshStateNoMoreData;
                            }
                        }

                    }
                   
                }
            }
            
        }else{
            [self show:NO target:self.activityIndicator background:self.activityIndicatorBackground];
            [self showAlert:@"解析错误" withType:0];
        }
        
    } failureBlock:^(NSString *error) {
         [self endRefresh];
         [self show:NO target:self.activityIndicator background:self.activityIndicatorBackground];
         NSLog(@"call back error : %@",error);
         [self showAlert:error withType:1];
    }];

}

- (void)endRefresh{
    
    if(self.VertificationRecordsTableView.mj_header.isRefreshing){
        [self.VertificationRecordsTableView.mj_header endRefreshing];
    }
    if (self.VertificationRecordsTableView.mj_footer.isRefreshing) {
        [self.VertificationRecordsTableView.mj_footer endRefreshing];
    }

}
- (void)startToGetNetData{
    if (type==0) {
      [ self initparams:GetRecordsList];
        
    }else if(type==1){
      [ self initparams:GetBillList];
    }
   
    [self getConnectNet:requestRecordsUrl withParams:dictionaryRequestBody];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (0==type) {
        
        RecordsDetail *ctrol=[self.storyboard instantiateViewControllerWithIdentifier:@"recordsdetailtableview"];
        ctrol.model=[datasource objectAtIndex:indexPath.row];
       
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:ctrol];
        
        [self presentViewController:navController animated:YES completion:nil];
        

       
    }else if(1==type){
        BillRecordsDetail *ctroller=[self.storyboard instantiateViewControllerWithIdentifier:@"recordsbilltableview"];
    
        ctroller.model=[datasource objectAtIndex:indexPath.row];
        
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:ctroller];
        
        [self presentViewController:navController animated:YES completion:nil];
    
    }
   
    
    
    NSLog(@"clicked line is %ld",indexPath.row);
   
    
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
/*暂未解决 header 一起滑动
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *infoAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"详情" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
       
        RecordsDetail *ctrol=[self.storyboard instantiateViewControllerWithIdentifier:@"recordsdetailtableview"];
        
        ctrol.model=[datasource objectAtIndex:indexPath.row];
        ctrol.type=type;
        //还有种方式 是直接 用 storyboard视图层加载 但值带不过去？？？
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:ctrol];
    
        [self presentViewController:navController animated:YES completion:nil];
        
        tableView.editing = NO;
        
    }];
    
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            [datasource removeObjectAtIndex:indexPath.row];
    
            // refresh
            [self.VertificationRecordsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            // 不需要主动退出编辑模式，上面更新view的操作完成后就会自动退出编辑模式
        }];
    
    return @[infoAction,deleteAction];
    
    
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *identify=@"vertificationrecordscell";
    VetificationrecordsCell * cell=[tableView dequeueReusableCellWithIdentifier:identify];
    
        [ cell setContentForCell:[datasource objectAtIndex:indexPath.row] withType:type];
        return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static  NSString *identify=@"recordcellheader";
     VertificationrecordsCellHeader *cellheader=[tableView dequeueReusableCellWithIdentifier:identify];
    
    NSDictionary *dic=nil;
    if (self.type==0) {
        
        dic=[NSDictionary dictionaryWithObjectsAndKeys:@"时间",@"date",@"姓名",@"content",@"项目",@"type", nil];
        
    }else if(self.type==1){
        dic=[NSDictionary dictionaryWithObjectsAndKeys:@"时间",@"date",@"金额",@"content",@"卡次/证次",@"type", nil];

    }
    [cellheader setTitles:dic];
    return cellheader;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return 55;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [datasource count];
    
}


#pragma mark Refresh
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
    page=@"0";
    [self getConnectNet:requestRecordsUrl withParams:dictionaryRequestBody];
}
- (void)loadMoreData{
    //备注:后台的分页处理机制 针对的是pc端
    divider+=19;
    page=[NSString stringWithFormat:@"%d",divider];
    NSLog(@"loadmore divider is %d and page is %@",divider,page);
    [self getConnectNet:requestRecordsUrl withParams:dictionaryRequestBody];
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
