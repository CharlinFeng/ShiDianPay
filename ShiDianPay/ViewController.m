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

@property (nonatomic,assign) BOOL isClickPayAPPBackBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self check];
}

- (IBAction)btnClick:(id)sender {
    
    self.isClickPayAPPBackBtn = NO;

    [ShiDianPay payWithType:ShiDianPayTypeAliPay money:@"0.02" orderID:@"alipay_ShiDianPay_036" title:@"新年快乐" desc:@"时点支付：ShiDianPay_FrameWork" completeClosure:^(NSString *errorMsg) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"ShiDianPay"];

        self.isClickPayAPPBackBtn = YES;
        
        if(errorMsg == nil){
            
            NSLog(@"支付成功回调");
            
        }else{
            
            NSLog(@"支付失败回调:%@",errorMsg);
        }
    }];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(check) name:UIApplicationDidBecomeActiveNotification object:nil];
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"baiduMap://"]];
}

-(void)check{
    
    if(self.isClickPayAPPBackBtn){
    
        NSLog(@"你按规矩来了");
        
    }else{
    

    }
}

@end
