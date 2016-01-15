//
//  ZExceptionHandler.m
//  Checklists
//
//  Created by 郑庆登(Qingdeng Zheng)-IT服务中心 on 15/12/28.
//  Copyright © 2015年 郑庆登(Qingdeng Zheng)-IT服务中心. All rights reserved.
//

#import "ZExceptionHandler.h"
#import <UIKit/UIKit.h>
@implementation ZExceptionHandler

void errorDeal(NSException* exception){
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
//    NSDictionary *content = [NSDictionary dictionaryWithObjects:@[name, reason, arr] forKeys:@[@"name", @"reason", @"callStackSymbols"]];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:zhengqingdeng2@sf-express.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
    NSLog(@"发生了一点错误:%@",exception);
    NSLog(@"YES");
}

+ (void)setDefaultHandler{
    // 在这里设置默认的处理函数处理程序异常
    NSSetUncaughtExceptionHandler (&errorDeal);
}

+ (NSUncaughtExceptionHandler*)getHandler{
    // 返回异常处理函数
    return NSGetUncaughtExceptionHandler();
}
@end
