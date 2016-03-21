//
//  ShiDianPay+WeChart.m
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ShiDianPay+WeChat.h"
#import "WXApi.h"
#import "DataMD5.h"
#import "NSString+ShiDianPay.h"
#import "XMLDictionary.h"

@interface ShiDianPay ()<WXApiDelegate>

@end

@implementation ShiDianPay (WeChart)

+(void)weChatHandleOpenURL:(NSURL *)url{

    [WXApi handleOpenURL:url delegate:[ShiDianPay sharedShiDianPay]];
}



+(void)payUseWeChatWithMoney:(NSString *)money orderID:(NSString *)orderID title:(NSString *)title desc:(NSString *)desc completeClosure:(void(^)(NSString *errorMsg))completeClosure{

    ShiDianPay *pay = [ShiDianPay sharedShiDianPay];
    
    if(!pay.isRegisterWeChatPay){
    
        pay.isRegisterWeChatPay = YES;
        
        [WXApi registerApp:ShiDianPay_WeChat_AppID withDescription:@"ShiDianPay_App"];
    }
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
    
    //配置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //应用APPID
    params[@"appid"] = ShiDianPay_WeChat_AppID;
    //微信支付商户号
    params[@"mch_id"] = ShiDianPay_WeChat_Mch_id;
    //产生随机字符串，这里最好使用和安卓端一致的生成逻辑
    NSString *nonce_str = [NSString generateTradeNO];
    params[@"nonce_str"] = nonce_str;
    //商品或支付单简要描述
    params[@"body"] = desc;
    //商户系统内部的订单号,32个字符内、可包含字母
    params[@"out_trade_no"] = orderID;
    //订单总金额，单位为分
    NSString *total_fee = [NSString stringWithFormat:@"%@",@((NSInteger)(money.floatValue * 100))];
    params[@"total_fee"] = total_fee;
    //获取本机IP地址，请再wifi环境下测试，否则获取的ip地址为error，正确格式应该是8.8.8.8
    NSString *spbill_create_ip = @"8.8.8.8";
    params[@"spbill_create_ip"] = spbill_create_ip;
    //接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
    params[@"notify_url"] = ShiDianPay_WeChat_NotifyURL;
    //交易类型，取值如下：JSAPI，NATIVE，APP
    NSString *trade_type = @"APP";
    params[@"trade_type"] = trade_type;
    
    //获取sign签名
    DataMD5 *data = [[DataMD5 alloc] initWithAppid:ShiDianPay_WeChat_AppID mch_id:ShiDianPay_WeChat_Mch_id nonce_str:nonce_str partner_id:ShiDianPay_WeChat_API_PartnerKey body:desc out_trade_no:orderID total_fee:total_fee spbill_create_ip:spbill_create_ip notify_url:ShiDianPay_WeChat_NotifyURL trade_type:trade_type];
    params[@"sign"] = [data getSignForMD5];
    
    // 转换成xml字符串
    NSString *xmlString = [NSString ConvertDictionarytoXML:params];
    NSLog(@"xmlString: %@",xmlString);
    //加载一个NSURL对象
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    //设置请求方式为POST
    [requestM setHTTPMethod:@"POST"];
    //设置请求头：JSON格式的请求头信息
    [requestM setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    //设置数据体
    NSData *xmlData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    [requestM setHTTPBody:xmlData];
    
    //POST请求
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString * dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if ( response != nil) {

            NSDictionary *dic = [NSDictionary dictionaryWithXMLString:dataString];
            NSLog(@"统一下单返回的结果：%@",dic);
            //判断返回的许可
            if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"] &&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
                //发起微信支付，设置参数
                PayReq *request = [[PayReq alloc] init];
                request.openID = [dic objectForKey:@"appid"];
                request.partnerId = [dic objectForKey:@"mch_id"];
                request.prepayId= [dic objectForKey:@"prepay_id"];
                request.package = @"Sign=WXPay";
                request.nonceStr= [dic objectForKey:@"nonce_str"];
                //将当前事件转化成时间戳
                NSDate *datenow = [NSDate date];
                NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                UInt32 timeStamp =[timeSp intValue];
                request.timeStamp= timeStamp;
                // 签名加密
                DataMD5 *md5 = [[DataMD5 alloc] init];
                request.sign=[md5 createMD5SingForPay:request.openID partnerid:request.partnerId prepayid:request.prepayId package:request.package noncestr:request.nonceStr timestamp:request.timeStamp];
                // 调用微信
                [WXApi sendReq:request];
                //记录
                pay.CompleteBlock = completeClosure;
                
            }else{
                
                //支付出错
                if(completeClosure != nil){completeClosure(@"统一下单API失败:2");}
            }

        }else{

            //服务器返回错误
            if(completeClosure != nil){completeClosure(@"统一下单API失败:1");}
        }
    }];

}




#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询

        switch (resp.errCode) {
            case WXSuccess:

                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                //支付结果：成功
                if(self.CompleteBlock != nil){self.CompleteBlock(nil);}
                break;
                
            default:

                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                //支付结果：失败
                if(self.CompleteBlock != nil){self.CompleteBlock(@"支付失败");}
                break;
        }
        
    }else{
        
        //类型错误
        if(self.CompleteBlock != nil){self.CompleteBlock(@"支付类型错误");}
    }
    
}

@end
