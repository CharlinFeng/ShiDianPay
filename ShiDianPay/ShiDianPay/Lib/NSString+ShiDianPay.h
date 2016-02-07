//
//  NSString+ShiDianPay.h
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ShiDianPay)

+(NSString *)generateTradeNO;

+(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary;

@end
