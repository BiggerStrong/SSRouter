//
//  SSURLTransition.m
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/6.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import "SSURLTransition.h"

@implementation SSURLTransition
SSSingletonM(SSURLTransition)


- (UIViewController*)currentViewController {
    UIViewController* rootViewController = self.applicationDelegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

- (UINavigationController*)currentNavigationViewController {
    UIViewController* currentViewController = self.currentViewController;
    return currentViewController.navigationController;
}

- (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

// 设置为根控制器
- (void)setRootViewController:(UIViewController *)viewController
{
    [SSURLTransition sharedSSURLTransition].applicationDelegate.window.rootViewController = viewController;
}

// 通过递归拿到当前控制器
- (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        // 如果传入的控制器是导航控制器,则返回最后一个
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        // 如果传入的控制器是tabBar控制器,则返回选中的那个
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if(viewController.presentedViewController != nil) {
        // 如果传入的控制器发生了modal,则就可以拿到modal的那个控制器
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

- (void)transitionViewController:(UIViewController *)viewController transitionType:(SSTransitionType) transitionType animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
{
    
    if (viewController) {
        switch (transitionType) {
            case SSTransitionTypePush: {
                if([viewController isKindOfClass:[UINavigationController class]]) {
                    // 如果是导航控制器直接设置为根控制器
                    [self setRootViewController:viewController];
                } else {
                    UINavigationController *navigationController = self.currentNavigationViewController;
                    if (navigationController) {
                        // 导航控制器存在
                        // 进行push
                        [navigationController pushViewController:viewController animated:animated];
                    }
                    else {
                        // 如果导航控制器不存在,就会创建一个新的,设置为根控制器
                        navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
                        [self setRootViewController:navigationController];
                    }
                }
                break;
            }
            case SSTransitionTypePop: {
                if (self.currentViewController) {
                    if (self.currentNavigationViewController) {
                        [self.currentNavigationViewController popViewControllerAnimated:animated];
                    }
                }
                break;
            }
            case SSTransitionTypePresent: {
                if (self.currentViewController) { // 当前控制器存在
                    [self.currentViewController presentViewController:viewController animated:animated completion:completion];
                } else { // 将控制器设置为根控制器
                    [self setRootViewController:viewController];
                }
                break;
            }
            case SSTransitionTypeDismiss: {
                if (self.currentViewController) {
                    [self.currentViewController dismissViewControllerAnimated:animated completion:completion];
                }
                break;
            }
                
            default:
                break;
        }
    }
}

@end
