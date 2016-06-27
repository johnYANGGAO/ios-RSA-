//
//  BasicInfoModel.m
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "BasicInfoModel.h"

@implementation BasicInfoModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.CompanyName forKey:@"CompanyName"];
    [aCoder encodeObject:self.Province forKey:@"Province"];
    [aCoder encodeObject:self.Status forKey:@"Status"];
    [aCoder encodeObject:self.City forKey:@"City"];
    
    [aCoder encodeObject:self.Address forKey:@"Address"];
    [aCoder encodeObject:self.LegalPerson forKey:@"LegalPerson"];
    [aCoder encodeObject:self.LegalMobile forKey:@"LegalMobile"];
    [aCoder encodeObject:self.LegalTel forKey:@"LegalTel"];
    [aCoder encodeObject:self.ContactPerson forKey:@"ContactPerson"];
    [aCoder encodeObject:self.ContactDept forKey:@"ContactDept"];
    [aCoder encodeObject:self.ContactTel forKey:@"ContactTel"];
    [aCoder encodeObject:self.ContactEmail forKey:@"ContactEmail"];
    
    [aCoder encodeObject:self.CompanyURL forKey:@"CompanyURL"];
    [aCoder encodeObject:self.InsertDate forKey:@"InsertDate"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self=[super init]){
        self.CompanyURL=[aDecoder decodeObjectForKey:@"CompanyURL"];
        self.InsertDate=[aDecoder decodeObjectForKey:@"InsertDate"];
        self.ContactEmail =[aDecoder decodeObjectForKey:@"ContactEmail"];
        self.ContactTel =[aDecoder decodeObjectForKey:@"ContactTel"];
        
        self.ContactDept=[aDecoder decodeObjectForKey:@"ContactDept"];
        self.ContactPerson=[aDecoder decodeObjectForKey:@"ContactPerson"];
        self.LegalTel =[aDecoder decodeObjectForKey:@"LegalTel"];
        self.LegalMobile =[aDecoder decodeObjectForKey:@"LegalMobile"];
        
        self.LegalPerson=[aDecoder decodeObjectForKey:@"LegalPerson"];
        self.Address=[aDecoder decodeObjectForKey:@"Address"];
        self.City =[aDecoder decodeObjectForKey:@"City"];
        self.CompanyName =[aDecoder decodeObjectForKey:@"CompanyName"];
        
        self.Status =[aDecoder decodeObjectForKey:@"Status"];
        self.Province =[aDecoder decodeObjectForKey:@"Province"];
        
        
    }
    return self;
}

@end
