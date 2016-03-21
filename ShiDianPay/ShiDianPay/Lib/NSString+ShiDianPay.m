//
//  NSString+ShiDianPay.m
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "NSString+ShiDianPay.h"

@implementation NSString (ShiDianPay)

-(NSString *)payParamsHandle:(NSDictionary *)payParams{

    NSMutableString *strM = [NSMutableString stringWithString:self];
    
    [payParams enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        
        [strM appendFormat:@"/%@/%@",key,obj];
    }];
    
    return strM.copy;
}


#pragma mark - 产生随机订单号
+(NSString *)generateTradeNO{
    
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0)); // 此行代码有警告:
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


+(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    NSArray *arr = [dictionary allKeys];
    [xml appendString:@"<xml>"];
    for(int i=0;i<[arr count];i++)
    {
        id nodeValue = [dictionary objectForKey:[arr objectAtIndex:i]];
        if([nodeValue isKindOfClass:[NSArray class]] )
        {
            if([nodeValue count]>0){
                for(int j=0;j<[nodeValue count];j++)
                {
                    id value = [nodeValue objectAtIndex:j];
                    if([ value isKindOfClass:[NSDictionary class]])
                    {
                        [xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
                        [xml appendString:[NSString stringWithFormat:@"%@",[value objectForKey:@"text"]]];
                        [xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
                    }
                    
                }
            }
        }
        else if([nodeValue isKindOfClass:[NSDictionary class]])
        {
            [xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
            if([[nodeValue objectForKey:@"Id"] isKindOfClass:[NSString class]])
                [xml appendString:[NSString stringWithFormat:@"%@",[nodeValue objectForKey:@"Id"]]];
            else
                [xml appendString:[NSString stringWithFormat:@"%@",[[nodeValue objectForKey:@"Id"] objectForKey:@"text"]]];
            [xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
        }
        
        else
        {
            if([nodeValue length]>0){
                [xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
                [xml appendString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:[arr objectAtIndex:i]]]];
                [xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
            }
        }
    }
    
    NSString *finalxml=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    [xml appendString:@"</xml>"];
    NSLog(@"%@",xml);
    return finalxml;
}


@end
