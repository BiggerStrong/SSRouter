//
//  SSURLTransition.h
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/6.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSSingleton.h"


NS_ASSUME_NONNULL_BEGIN
@interface SSURLTransition : NSObject
SSSingletonH(SSURLTransition)


/**
 当前控制器

 @return 返回当前控制器
 */
- (UIViewController *)currentViewController;

/**
 当前导航控制器

 @return 返回当前导航控制器
 */
- (UINavigationController*)currentNavigationViewController;

/**
 转场

 @param viewController 控制器
 @param animated 动画
 @param completion 回调
 */
- (void)transitionViewController:(UIViewController *)viewController transitionType:(SSTransitionType) transitionType animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

NS_ASSUME_NONNULL_END
@end
