//
//  ShiDianPayConst.h
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#ifndef ShiDianPayConst_h
#define ShiDianPayConst_h


/*
 *  使用说明
 
 1.申请支付宝、微信支付
 
 2.下载对应SDK，如果SDK没有 更新直接使用当前SDK
 
 3.$(PROJECT_DIR)/$(TARGET_NAME)/Frameworks/ShiDianPay/Lib/Alipay
 
 4.解决编译错误：
    .CoreMotion.framework
    .SystemConfiguration.framework
    .CoreTelephony.framework
    .libz.tbd
    .libsqlite3.tbd
    .mm
 
 5.应用跳转
 应用需要在“Info.plist”中将要使用的URL Schemes（跳转程序）列为白名单，
 注：如果项目中第三方分享用的是友盟，在注册的时候要把友盟注册放在微信注册的前面执行。如下：
    <key>LSApplicationQueriesSchemes</key>
    <array>
     <string>weixin</string>
    </array>
 
 6.填写Scheme
   对于支付宝，填写自己的app的scheme，如：Yeah
   对于微信支付，填写微信AppId
 
 7.请补充填写以下配置信息
 
 */















typedef enum{
    
    /** 支付宝 */
    ShiDianPayTypeAliPay = 0,
    
    /** 微信支付 */
    ShiDianPayTypeWechat
    
} ShiDianPayType;



/*
 *  支付宝重要信息定义
 */

/** partner */
#define ShiDianPay_Alipay_Partner @"2088121820533203"

/** seller */
#define ShiDianPay_Alipay_Seller @"yeyeahapp@163.com"

/** privateKey：PKCS8格式的私钥 */
#define ShiDianPay_Alipay_PrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAL4pAzAE8qM6uBUB4LT8jfIgpsS+k9uGVGvVvkaFGpTWi1kyrU3ljwIZsmAAK0Qivlsn9rg9D+IQnVCuUKzmysWsQp9FqlptfL3OLfCcwzlZvi+4+vKI/Ad8aGCR21cd9LfKDXv8fxZMfEjboTkFTLiPYsDDClK7OGYaGFtIoa8FAgMBAAECgYAoi+ooFQX/lAeoQww8yxUhKaElllVEm7HohFzcAImYbt6rmEinsWj606vbGG4hSx83pJ/QzQRT+aLxjxmYpGVbvc/dXj1Pv6a8c59B5gsXC32+yuZIBpvzMmMenCUhRpffJpHczqwiom7MUpRA5HkTVIC9xOIidvMVqCYLc2EDgQJBAP1NrobAtfi7lorKB9m4ACfQZz6q4fWIsPGjJsBKKkawyNDRCTf+WPvucpNlGlzmR/JaF8JX+FoEXNiUjoaBYJECQQDALz+zsEPkt0JCjYpa0rSWDM/B2ZemPz2C2bnG8kfGpYu1i2GS6ZPm0qs0n0aeQGlnNYndtS+swxopJ7IPBiE1AkEA4uqyTHlbC0ZRaGfwfHQ/f2tM8nD3F5Sqnu1/i4dlNAqu+5In5gdvA9HqxmwuH8cT8OIQosNX8pwx6Lu8qnZAYQJASfxmm7iKCqz6V0DCOMDRQMrh2JD6Lsg91/gV6x8uvqzQoi1sfPBrPftwaau/tgC6Ez+rOa0dE3dwxNNBW0NS2QJAfwN/OEdzH8/Wc4pwijMXZALj+qnkkCNM5rjrx7NDeZp9rKHS26Wd+Fp0z1G4KysSLliKrs8+ZXLniqx4dn0lgg=="

/** notifyURL */
#define ShiDianPay_Alipay_NotifyURL @"http://120.25.157.128/yeah/Home/Info"

/** appScheme */
#define ShiDianPay_Alipay_AppScheme @"Yeah"








/*
 *  微信支付重要信息定义
 */

/** 微信开发平台：AppID */
#define ShiDianPay_WeChat_AppID @"wx8f69e8edc2d6cda7"

/** 微信开发平台：AppSecret */
#define ShiDianPay_WeChat_AppSecret @"d90cfc8d0b9f95427aa1ce50331a435c"

/** 微信支付商号 */
#define ShiDianPay_WeChat_Mch_id @"1309808001"

/** notifyURL */
#define ShiDianPay_WeChat_NotifyURL ShiDianPay_Alipay_NotifyURL

/** API_PartnerKey */
#define ShiDianPay_WeChat_API_PartnerKey @"c444b3dd92bc485e1c8e0de95449c82d"

#endif
/* ShiDianPayConst_h */
