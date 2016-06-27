//
//  FirstTabbarItem.m
//  Verification
//
//  Created by john's mac　　　　 on 4/5/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "FirstTabbarItem.h"
#import "BaseCell.h"
#import "VertificatonUI.h"
@interface FirstTabbarItem(){
   }

@end
@implementation FirstTabbarItem


- (void)viewDidLoad{
    [super viewDidLoad];
    /**
     TODO
     */
    [self initDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initDataSource{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"VertificationCategory" ofType:@"plist"];
    
    datasource=[[NSMutableArray alloc] initWithContentsOfFile:path];
    
    self.FirstMainTabView.delegate=self;
    self.FirstMainTabView.dataSource=self;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    //黑屏
    //    VertificatonUI *vertify=[[VertificatonUI alloc]init];
    VertificatonUI *vertify=[self.storyboard instantiateViewControllerWithIdentifier:@"SBRIGHT"];
    vertify.type=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    //用push 报错
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vertify];
    
    [self presentViewController:navController animated:YES completion:nil];
    NSLog(@"clicked at %ld ",(long)indexPath.row);

}
/**
 *此方法 在tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 提前执行 可能我没理解好？
 */
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"FirstVertificationType"])     {
//        id theSegue = segue.destinationViewController;
//        
//        if(_type==0){
//            [theSegue setValue:@"0" forKey:@"type"];//注意arc要是oc对象
//             NSLog(@"send 0");
//        }else{
//            [theSegue setValue:@"1" forKey:@"type"];
//            NSLog(@"send 1");
//
//        }
//    }
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datasource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"BaseCell";
    
    BaseCell * basecell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
     NSDictionary *dataDic = datasource[indexPath.row];
    
    [basecell setLabel:dataDic];
    
    
    return basecell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
@end
