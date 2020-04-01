//
//  ViewController.m
//  FishhookDemo
//
//  Created by Alan on 4/1/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "ViewController.h"
#import "fishhook.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    //使用rebinding 结构体
    struct rebinding nslog;
    nslog.name = "NSLog";//要hook的函数名称
    nslog.replacement = myNSLog;//这里是函数的指针，也就是函数名称
    nslog.replaced = &sys_nslog;
//    rebinding 结构体数组
    struct rebinding rebs[1] = {nslog};
    /***
     存放rebinding 结构体数组
     数组长度
     */
    rebind_symbols(rebs, 1);
    
    
    
    // Do any additional setup after loading the view.
}
//---------修改的NSLog---------
//NSLog函数指针
static void(*sys_nslog)(NSString * format,...);
//定义一个新函数
void myNSLog(NSString *format,...){
    format = [format stringByAppendingString:@"~~~~~hook 到了!"];
    sys_nslog(format);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击了屏幕");
}


@end
