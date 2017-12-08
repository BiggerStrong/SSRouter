//
//  ViewController.m
//  SSRouteDemo
//
//  Created by yuqiang on 2017/11/30.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SSRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 防止block中的循环引用
    __weak typeof (self) weakSelf = self;
//    // 初始化一个View
//    UIView *bgView = [[UIView alloc]init];
//    bgView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:bgView];
//    // 使用mas_makeConstraints添加约束
////    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.center.equalTo(weakSelf.view);
////        make.size.mas_equalTo(CGSizeMake(200, 200));
////    }];
////
////    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
////        make.size.mas_equalTo(CGSizeMake(100, 50));
////    }];
//
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weakSelf.view);
//        make.edges.mas_offset(UIEdgeInsetsMake(10, 10, 10, 10));
//    }];
    
    
    UIButton *view1 = [[UIButton alloc]init];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.centerX.equalTo(weakSelf.view);
        make.top.width.offset(90);
    }];
    
    [view1 addTarget:self action:@selector(handlePushNext) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *view2 = [[UILabel alloc]init];
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(view1);
        make.top.equalTo(view1.mas_bottom).with.offset(20);
    }];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handlePushNext
{
//    //不带导航
    [[SSRouter sharedSSRouter]openURLString:@"shansong://01/push?test=sun" completion:nil];
//
//    //带导航
//    [[SSRouter sharedSSRouter]openURLString:@"shansong://01/push?name=sun" completion:nil];
    
    //导航
//    [[SSRouter sharedSSRouter]openURLString:@"shansong://02/push?name=sun" completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
