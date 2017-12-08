//
//  UIViewController+SSRouter.m
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/6.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import "UIViewController+SSRouter.h"
#import <objc/runtime.h>

static char URLOriginUrl;
static char URLOriginParams;

static char dataCallBack;
static char dataType;

@implementation UIViewController (SSRouter)

#pragma mark - properties
- (void)setOriginUrl:(NSURL *)originUrl
{
    objc_setAssociatedObject(self, &URLOriginUrl, originUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)originUrl
{
    return objc_getAssociatedObject(self, &URLOriginUrl);
}

- (void)setTransitionType:(NSString *)transitionType
{
    objc_setAssociatedObject(self, &dataType, transitionType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)transitionType
{
    return objc_getAssociatedObject(self, &dataType);
}

- (void)setOriginParams:(NSDictionary *)originParams
{
    objc_setAssociatedObject(self, &URLOriginParams, originParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)originParams
{
    return objc_getAssociatedObject(self, &URLOriginParams);
}

- (void)setValueBlock:(void (^)(id _Nonnull))valueBlock
{
    objc_setAssociatedObject(self, &dataCallBack, valueBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(id _Nonnull))valueBlock
{
    return objc_getAssociatedObject(self, &dataCallBack);
}

+ (UIViewController *)initFromString:(NSString *)urlString params:(NSDictionary *)params config:(NSDictionary *)configDictionary
{
    // 支持对中文字符的编码
    NSString *encodeString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodeString];
    
    UIViewController *viewController = [[UIViewController alloc]init];
    NSString *homeString;
    
    NSLog(@"%@",configDictionary);
    NSLog(@"%@",url);// shansong://main/push?name=sun
    NSLog(@"%@",url.path);// /push
    NSLog(@"%@",url.host);// main
    NSLog(@"%@",url.scheme);// shansong
    
    // 当前协议 shansong://01
    homeString = [NSString stringWithFormat:@"%@://%@", url.scheme, url.host];
    
    //配置里面有当前协议
    if ([configDictionary.allKeys containsObject:homeString]) {
        Class class = nil;
        class = NSClassFromString([configDictionary objectForKey:homeString]);
        if (class == nil) {
            // 兼容swift,字符串转类名的时候前面加上命名空间
            NSString *spaceName = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
            NSLog(@"%@",spaceName);
            class = NSClassFromString([NSString stringWithFormat:@"%@.%@",spaceName,[configDictionary objectForKey:homeString]]);
        }
        
        if(class != nil){
            viewController = [[class alloc]init];
            if([viewController respondsToSelector:@selector(open:withParams:)]){
                [viewController open:url withParams:params];
            }
        }
    }
    
    // 转场类型
    viewController.transitionType = url.path;
    
    return viewController;
}

- (void)open:(NSURL *)url withParams:(NSDictionary *)params{
//    self.originPath = [url path];
    NSLog(@"%@",url);
    NSLog(@"%@",params);
    self.originUrl = url;
    if (params) {   // 如果自定义url后面有拼接参数,而且又通过query传入了参数,那么优先query传入了参数
        self.originParams = params;
    }else {
        self.originParams = [self paramsURL:url];
    }
}

// 将url的参数部分转化成字典
- (NSDictionary *)paramsURL:(NSURL *)url {
    NSLog(@"%@",url);
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [url.absoluteString rangeOfString:@"?"].location) {
        NSString *paramString = [url.absoluteString substringFromIndex:
                                 ([url.absoluteString rangeOfString:@"?"].location + 1)];
        
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0] stringByRemovingPercentEncoding];
                NSString* value = [[kvPair objectAtIndex:1] stringByRemovingPercentEncoding];
                [pairs setValue:value forKey:key];
            }
        }
    }
    
    NSLog(@"%@",pairs);
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}




@end
