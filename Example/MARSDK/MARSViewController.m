//
//  MARSViewController.m
//  MARSDK
//
//  Created by wanghuizhou21@163.com on 06/12/2018.
//  Copyright (c) 2018 wanghuizhou21@163.com. All rights reserved.
//

#import "MARSViewController.h"
#import <MARSDK/XLogHelper.h>
#import "MARSDK_Example-Swift.h"
@interface MARSViewController ()

@end

@implementation MARSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    //
    

   
    
    
}
- (IBAction)onBtnConfig:(id)sender {
    //配置
    [XLogHelper ConfigXloggerWithPath:@"/xlog"
                      filenamePrefix:@"demo"
                           publicKey:@""
                               level:info //only xlog level >= this level will be append to xlog
                        isConsoleLog:true
    ];
}
- (IBAction)onBtnLog:(id)sender {
    //打印 （使用宏）
    LOG_INFO(   "TEST", @"%@",@"LOG is Ok!!! this will be show ");
    LOG_DEBUG(  "TEST", @"%@",@"this won't be show"); // because set level to info ,this won't be show
}


- (IBAction)onBtn:(id)sender {
//    [SwiftViewController new];
    [self presentViewController:[SwiftViewController new] animated:true completion:nil];
}


@end
 
