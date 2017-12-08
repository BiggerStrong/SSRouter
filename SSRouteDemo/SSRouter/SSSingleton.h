//
//  SSSingleton.h
//  SSRouteDemo
//
//  Created by yuqiang on 2017/12/6.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#ifndef SSSingleton_h
#define SSSingleton_h

// .h文件
#define SSSingletonH(name) + (instancetype)shared##name;
// .m文件
#define SSSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

//转场类型
typedef NS_ENUM(NSInteger, SSTransitionType) {
    SSTransitionTypePush = 0,           //push
    SSTransitionTypePop,                //pop
    SSTransitionTypePresent,            //present
    SSTransitionTypeDismiss,            //dismiss
    SSTransitionTypeNone                //none
};






#endif /* SSSingleton_h */
