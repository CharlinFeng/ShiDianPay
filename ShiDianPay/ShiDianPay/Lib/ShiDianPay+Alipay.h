//
//  ShiDianPay+Alipay.h
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ShiDianPay.h"

@interface ShiDianPay (Alipay)


+(void)aliPayHandleOpenURL:(NSURL *)url;

+(void)payUseAlipayWithMoney:(NSString *)money orderID:(NSString *)orderID title:(NSString *)title desc:(NSString *)desc completeClosure:(void(^)(NSString *errorMsg))completeClosure;

@end
