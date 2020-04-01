//
//  ViewController.m
//  FishHOOK防护
//
//  Created by Alan on 4/1/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "ViewController.h"
#import "fishhook.h"
#import <objc/runtime.h>

@interface ViewController ()

@end


@implementation ViewController
+(void)load
{
    /**
     防护代码：
     这里使用fishHOOK 对method_exchangeImplementations进行HOOK替换即可
     */
    struct rebinding bd;
    bd.name = "method_exchangeImplementations";
    bd.replacement = myExchange;
    bd.replaced = (void *)&exchangeP;
    struct rebinding rebs[1] = {bd};
    rebind_symbols(rebs, 1);
    
    
    
    
/**
    进攻代码
    通过exchangeIMP 修改PayClick 调用我自己的方法
 
    这里进攻代码也可以使用setImp  和getIMP方式进行原理基本一致 其中Cydia Substrate 就是针对setImp 和
 getImp 进行hook的
 
 */
    Method old = class_getInstanceMethod(self, @selector(PayClick:));

    Method newMethod = class_getInstanceMethod(self, @selector(payHookClick:));
    
    method_exchangeImplementations(old, newMethod);
    
    
}

- (void)payHookClick:(id)sender
{
    NSLog(@"勾着支付了");
}

#pragma mark ---- 防护代码------
//函数指针变量
void(*exchangeP)(Method _Nonnull m1, Method _Nonnull m2);

void myExchange(Method _Nonnull m1, Method _Nonnull m2)
{
    NSLog(@"恶意代码HOOK");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)PayClick:(id)sender {
    NSLog(@"支付500万");
}
- (IBAction)loginClick:(id)sender {
    NSLog(@"登陆了");
}

@end
