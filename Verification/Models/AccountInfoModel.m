//
//  AccountInfoModel.m
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "AccountInfoModel.h"

@implementation AccountInfoModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",self.Beforehand ]forKey:@"Beforehand"];
    [aCoder encodeObject:self.Deposit forKey:@"Deposit"];
    [aCoder encodeObject:self.Money forKey:@"Money"];
    [aCoder encodeObject:self.TotalExpeditureMoney forKey:@"TotalExpeditureMoney"];
    
    [aCoder encodeObject:self.WarnLimit forKey:@"WarnLimit"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",self.IsOpenWarn ] forKey:@"IsOpenWarn"];
    [aCoder encodeObject:self.Phone forKey:@"Phone"];
    [aCoder encodeObject:self.Email forKey:@"Email"];

   
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        NSString *bfh=[aDecoder decodeObjectForKey:@"Beforehand"];
        NSString *iow=[aDecoder decodeObjectForKey:@"IsOpenWarn"];
        self.Beforehand=bfh.intValue;
        self.Deposit=[aDecoder decodeObjectForKey:@"Deposit"];
        self.Money =[aDecoder decodeObjectForKey:@"Money"];
        self.TotalExpeditureMoney =[aDecoder decodeObjectForKey:@"TotalExpeditureMoney"];
        
        self.WarnLimit=[aDecoder decodeObjectForKey:@"WarnLimit"];
        self.Email=[aDecoder decodeObjectForKey:@"Email"];
        self.Phone =[aDecoder decodeObjectForKey:@"Phone"];
        self.IsOpenWarn =iow.intValue;
    
    }

    return self;

}

@end
