//
//  MyKeyStore.h
//  Verification
//
//  Created by john's mac　　　　 on 5/31/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#ifndef MyKeyStore_h
#define MyKeyStore_h
#define PublicKey_vertification @"your public key"
#define AES_IV   @"0000000000000000"
#define PrivateKey_vertification  @"your private key"

#define BaseUrl @"http://xxxx.com/api/"
#define LoginUrl @"Users/Login?login"
#define GetCompanyInfoUrl @"Company/ById?login"
#define VertificationByID  @"Verify/IDCard?login"
#define VertificationByBank  @"Verify/BankCard?login"
#define GetRecordsList @"Logs/GetVerify?login"
#define GetBillList  @"Logs/GetCompanyBill?login"

#define SSKey_service @"vertification"
#define UserInfoKey  @"userinfo"
#define SSKey_key_name @"login"


#endif /* MyKeyStore_h */
