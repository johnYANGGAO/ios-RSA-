//
//  RecordsDetail.m
//  Verification
//
//  Created by john's mac　　　　 on 4/7/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "RecordsDetail.h"

@interface RecordsDetail (){
    
}

@end

@implementation RecordsDetail

@synthesize model;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initViews];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)initViews{

    self.name.text=model.name;
    self.money.text=model.money;
    self.projectName.text=model.project;
    self.creditCardNum.text=model.creditCard;
    self.IpAdress.text=model.ipAdress;
    self.date.text=model.time;
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return [AcellCount count];
        
    }else if (section==1){
      return [BcellCount count];
    
    }else if(section==2){
    
      return [CcellCount count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    if (indexPath.section==0) {
        
        NSString *identify=[AcellCount objectAtIndex:indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
         NSLog(@"cell s0 success");
        return cell;
        
    }else if (indexPath.section==1){
       
        NSString *identify=[BcellCount objectAtIndex:indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        if(cell==nil){
        
            NSLog(@"cell is nil");
        
        }
        NSLog(@"cell s1 success");

        return cell;

    }else if(indexPath.section==2){
        NSString *identify=[CcellCount objectAtIndex:indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        NSLog(@"cell s2 success");

        return cell;
        
    }
    
    return nil;
}

*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.section==2){
    
        if (indexPath.row==0) {
            NSLog(@"马上开启result");
        }
    
    }

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}


- (IBAction)quit:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
