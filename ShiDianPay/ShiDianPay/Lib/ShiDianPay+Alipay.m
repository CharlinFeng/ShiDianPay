//
//  ShiDianPay+Alipay.m
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ShiDianPay+Alipay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"
#import "NSString+ShiDianPay.h"


@implementation ShiDianPay (Alipay)


+(void)aliPayHandleOpenURL:(NSURL *)url{

    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"来了");
            
            ShiDianPay *pay = [ShiDianPay sharedShiDianPay];
            
            NSString *resStr = resultDic[@"memo"];
            NSInteger resCode = [resultDic[@"resultStatus"] integerValue];
            NSString *errorMsg_Temp = resCode != 9000 ? resStr : nil;
            if(pay.CompleteBlock != nil){pay.CompleteBlock(errorMsg_Temp);}
        }];
    }
}




+(void)payUseAlipayWithAccountModel:(ShiDianPayAccountModel *)accountModel money:(NSString *)money orderID:(NSString *)orderID title:(NSString *)title desc:(NSString *)desc completeClosure:(void(^)(NSString *errorMsg))completeClosure{
    
    ShiDianPay *pay = [ShiDianPay sharedShiDianPay];
    pay.CompleteBlock = completeClosure;
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = nil;
    NSString *seller = nil;
    NSString *privateKey = nil;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    NSString *notifyURL = nil;
    
    if (accountModel != nil){
        
        partner = accountModel.aliPay_partner;
        seller = accountModel.aliPay_seller;
        privateKey = accountModel.privateKey;
        notifyURL = accountModel.notifyURL;
        
    }else {
        
        partner = ShiDianPay_Alipay_Partner;
        seller = ShiDianPay_Alipay_Seller;
        privateKey = ShiDianPay_Alipay_PrivateKey;
        notifyURL = ShiDianPay_Alipay_NotifyURL;
    }
    
    
    
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        
        if(completeClosure != nil){completeClosure(@"参数未配置！");}
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = title; //商品标题
    order.productDescription = desc; //商品描述
    order.amount = money; //商品价格
    order.notifyURL = notifyURL; //回调URL

    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = ShiDianPay_Alipay_AppScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"来了");
            
            NSString *resStr = resultDic[@"memo"];
            NSInteger resCode = [resultDic[@"resultStatus"] integerValue];
            NSString *errorMsg_Temp = resCode != 9000 ? resStr : nil;
            if(completeClosure != nil){completeClosure(errorMsg_Temp);}
        }];
    }    
}

@end
