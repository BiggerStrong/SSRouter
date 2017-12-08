//
//  SSRouter.h
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/5.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+SSRouter.h"
#import "SSSingleton.h"
#import "SSURLTransition.h"

NS_ASSUME_NONNULL_BEGIN
@interface SSRouter : NSObject
SSSingletonH(SSRouter)


/**
 加载plist文件中的URL配置信息

 @param plistName plist文件名称,不用加后缀
 */
- (void)loadConfigDictionaryWithPlist:(NSString *)plistName;

/**
 跳转URL

 @param urlString 自定义URL
 @param completion 回调
 */
- (void)openURLString:(NSString *)urlString completion:(void (^ __nullable)(void))completion;

/**
 跳转URL

 @param urlString 自定义URL
 @param animated 动画
 @param completion 回调
 */
- (void)openURLString:(NSString *)urlString animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

/**
 跳转URL

 @param urlString 自定义URL
 @param params 自定义参数
 @param completion 回调
 */
- (void)openURLString:(NSString *)urlString params:(NSDictionary *)params completion:(void (^ __nullable)(void))completion;

/**
 跳转URL

 @param urlString 自定义URL
 @param animated 动画
 @param params 自定义参数
 @param completion 回调
 */
- (void)openURLString:(NSString *)urlString animated:(BOOL)animated params:(NSDictionary * _Nullable)params completion:(void (^ __nullable)(void))completion;

NS_ASSUME_NONNULL_END
@end
