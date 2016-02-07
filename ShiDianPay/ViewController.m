//
//  ViewController.m
//  ShiDianPay
//
//  Created by 冯成林 on 16/2/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "ShiDianPay.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (IBAction)btnClick:(id)sender {
    
    [ShiDianPay payWithType:ShiDianPayTypeWechat money:0.01 orderID:@"ShiDianPay_007" title:@"支付宝_新年快乐" desc:@"时点支付：ShiDianPay_FrameWork" completeClosure:^(NSString *errorMsg) {
        
        if(errorMsg == nil){
            
            NSLog(@"支付成功");
        }else{
            
            NSLog(@"支付失败:%@",errorMsg);
        }
    }];
}


@end
