//
//  ShiDianPay.h
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ShiDianPayConst.h"
#import "ShiDianPaySingleton.h"



@interface ShiDianPay : NSObject
HMSingletonH(ShiDianPay)

@property (nonatomic,assign) BOOL isRegisterWeChatPay;
@property (nonatomic,copy) void(^CompleteBlock)(NSString *errorMsg);


+(void)handleOpenURL:(NSURL *)url;


+(void)payWithType:(ShiDianPayType)type money:(CGFloat)money orderID:(NSString *)orderID title:(NSString *)title desc:(NSString *)desc completeClosure:(void(^)(NSString *errorMsg))completeClosure;


@end
