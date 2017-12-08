//
//  MainViewController.m
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/7.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+SSRouter.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
//    self.test
    NSLog(@"%@",self.originUrl);
    NSLog(@"%@",self.originParams);
    NSLog(@"%@",self.valueBlock);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
