//
//  VertifiactionrecordsCellHeader.m
//  Verification
//
//  Created by john's mac　　　　 on 6/15/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "VertificationrecordsCellHeader.h"

@implementation VertificationrecordsCellHeader


- (void)setTitles:(NSDictionary *)dic{

    if(dic){
        
        self.titledate.text=dic[@"date"];
        self.titlecontent.text=dic[@"content"];
        self.titletype.text=dic[@"type"];
    
    }

}



@end
