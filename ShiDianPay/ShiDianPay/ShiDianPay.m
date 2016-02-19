//
//  ShiDianPay.m
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ShiDianPay.h"
#import "ShiDianPay+Alipay.h"
#import "ShiDianPay+WeChat.h"

@implementation ShiDianPay
HMSingletonM(ShiDianPay)


+(void)handleOpenURL:(NSURL *)url{

    [ShiDianPay aliPayHandleOpenURL:url];
    [ShiDianPay weChatHandleOpenURL:url];
}



+(void)payWithType:(ShiDianPayType)type money:(NSString *)money orderID:(NSString *)orderID title:(NSString *)title desc:(NSString *)desc completeClosure:(void(^)(NSString *errorMsg))completeClosure{

    if(type == ShiDianPayTypeAliPay){
    
        [self payUseAlipayWithMoney:money orderID:orderID title:title desc:desc completeClosure:completeClosure];
        
    }else{
        
        [self payUseWeChatWithMoney:money orderID:orderID title:title desc:desc completeClosure:completeClosure];
    }
}

@end
