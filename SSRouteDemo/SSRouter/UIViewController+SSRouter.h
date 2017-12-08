//
//  UIViewController+SSRouter.h
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/6.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSSingleton.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (SSRouter)

/** 跳转后控制器能拿到的url */
@property(nonatomic, strong) NSURL *originUrl;

/** 跳转后控制器能拿到的参数 */
@property(nonatomic,strong) NSDictionary *originParams;

/** 回调block */
@property (nonatomic, strong) void(^valueBlock)(id value);

/** 转场类型 */
@property(nonatomic,copy) NSString *transitionType;



// 根据参数创建控制器
+ (UIViewController *)initFromString:(NSString *)urlString params:(NSDictionary *)params config:(NSDictionary *)configDictionary;


NS_ASSUME_NONNULL_END

@end
