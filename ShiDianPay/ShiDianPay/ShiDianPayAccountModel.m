//
//  ShiDianPayAccountModel.m
//  ShiDianPay
//
//  Created by 冯成林 on 16/6/29.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ShiDianPayAccountModel.h"
#import <UIKit/UIKit.h>


@implementation ShiDianPayAccountModel


/** 快速实例化 */
+(instancetype)modelWithNotifyURL:(NSString *)notifyURL{

    ShiDianPayAccountModel *m = [self new];
    m.notifyURL = notifyURL;
    
    return m;
}


/** 支付宝数据填充 */
-(void)aliPayFillWithPrivateKey:(NSString *)privateKey partner:(NSString *)partner seller:(NSString *)seller{

    self.privateKey = privateKey;
    self.aliPay_partner = partner;
    self.aliPay_seller = seller;
}


/** 微信数据填充 */
-(void)wechatFillWithAppID:(NSString *)appID mch_id:(NSString *)mch_id partnerKey:(NSString *)partnerKey{

    self.wechat_AppID = appID;
    self.weChat_Mch_id = mch_id;
    self.weChat_API_PartnerKey = partnerKey;
}


/** 数据检查 */
-(void)aliPayCheck{
    
    NSString *errorMsg = nil;
    
    if(self.privateKey.length == 0) {errorMsg = @"支付宝的privateKey不能为空";}
    if(self.aliPay_partner.length == 0) {errorMsg = @"支付宝的partner不能为空";}
    if(self.aliPay_seller.length == 0) {errorMsg = @"支付宝的seller不能为空";}
    
    if (errorMsg != nil){
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付宝参数错误" message:errorMsg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
-(void)wechatCheck{

    NSString *errorMsg = nil;
    
    if(self.wechat_AppID.length == 0) {errorMsg = @"微信支付的appID为空";}
    if(self.weChat_Mch_id.length == 0) {errorMsg = @"微信支付的mch_id为空";}
    if(self.weChat_API_PartnerKey.length == 0) {errorMsg = @"微信支付的partnerKey为空";}
    
    if (errorMsg != nil){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"微信支付参数错误" message:errorMsg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
