//
//  SSRouter.m
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/5.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import "SSRouter.h"


NS_ASSUME_NONNULL_BEGIN
@interface SSRouter()

/** 存储读取的plist文件数据 */
@property(nonatomic,strong) NSDictionary *configDictionary;

@end

@implementation SSRouter
SSSingletonM(SSRouter)



- (void)loadConfigDictionaryWithPlist:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSDictionary *configDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDictionary) {
        [SSRouter sharedSSRouter].configDictionary = configDictionary;
    }
}

- (void)openURLString:(NSString *)urlString completion:(void (^ __nullable)(void))completion
{
    [self openURLString:urlString animated:YES params:nil completion:completion];
}

- (void)openURLString:(NSString *)urlString animated:(BOOL)animated completion:(void (^ __nullable)(void))completion
{
    [self openURLString:urlString animated:animated params:nil completion:completion];
}

- (void)openURLString:(NSString *)urlString params:(NSDictionary *)params completion:(void (^ __nullable)(void))completion
{
    [self openURLString:urlString animated:YES params:params completion:completion];
}

- (void)openURLString:(NSString *)urlString animated:(BOOL)animated params:(NSDictionary * _Nullable)params completion:(void (^ __nullable)(void))completion
{
    UIViewController *viewController = [UIViewController initFromString:urlString params:params config:[SSRouter sharedSSRouter].configDictionary];
    
    SSTransitionType transitionType = [self transitionTypeWithType:viewController.transitionType];
    
    if (transitionType != SSTransitionTypeNone) {
        [[SSURLTransition sharedSSURLTransition]transitionViewController:viewController transitionType:transitionType animated:animated completion:completion];
    }
}


- (SSTransitionType)transitionTypeWithType:(NSString *)type
{
    NSLog(@"%@",type);
    SSTransitionType transitionType;
    if ([type isEqualToString:@"/push"])
    {
        transitionType = SSTransitionTypePush;
    }
    else if ([type isEqualToString:@"/pop"])
    {
        transitionType = SSTransitionTypePop;
    }
    else if ([type isEqualToString:@"/present"])
    {
        transitionType = SSTransitionTypePresent;
    }
    else if ([type isEqualToString:@"/dismiss"])
    {
        transitionType = SSTransitionTypeDismiss;
    }
    else {
        transitionType = SSTransitionTypeNone;
    }
    
    return transitionType;
}


NS_ASSUME_NONNULL_END
@end
