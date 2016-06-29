//
//  ShiDianPayAccountModel.h
//  ShiDianPay
//
//  Created by 冯成林 on 16/6/29.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShiDianPayAccountModel : NSObject


/*
 *  全局
 */

/** 密钥 */
@property (nonatomic,copy) NSString *privateKey;

/** 回调地址 */
@property (nonatomic,copy) NSString *notifyURL;




/*
 *  支付宝
 */

/** partner */
@property (nonatomic,copy) NSString *aliPay_partner;

/** 支付宝收款账号 */
@property (nonatomic,copy) NSString *aliPay_seller;




/*
 *  微信支付
 */

/** 微信开发平台：AppID */
@property (nonatomic,copy) NSString *wechat_AppID;

/** 微信支付商号 */
@property (nonatomic,copy) NSString *weChat_Mch_id;

/** API_PartnerKey */
@property (nonatomic,copy) NSString *weChat_API_PartnerKey;


/** 快速实例化 */
+(instancetype)modelWithNotifyURL:(NSString *)notifyURL;


/** 支付宝数据填充 */
-(void)aliPayFillWithPrivateKey:(NSString *)privateKey partner:(NSString *)partner seller:(NSString *)seller;


/** 微信数据填充 */
-(void)wechatFillWithAppID:(NSString *)appID mch_id:(NSString *)mch_id partnerKey:(NSString *)partnerKey;


/** 数据检查 */
-(void)aliPayCheck;
-(void)wechatCheck;


@end
