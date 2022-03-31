//
//  NSBundle+XY.m
//  IAPTest
//
//  Created by Yostar on 2020/6/5.
//  Copyright © 2020 Yostar. All rights reserved.
//

#import "NSBundle+XY.h"
#import <objc/runtime.h>

static NSString *const XYUserLanguageKey = @"XYUserLanguageKey";
#define STANDARD_USER_DEFAULT  [NSUserDefaults standardUserDefaults]

@interface XYBundleSubClass : NSBundle

@end

@implementation XYBundleSubClass

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    if ([XYBundleSubClass currentMainBundle]) {
        return [[XYBundleSubClass currentMainBundle] localizedStringForKey:key value:value table:tableName];
    } else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

+ (NSBundle *)currentMainBundle{
    if ([NSBundle currentLanguage].length) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSBundle currentLanguage] ofType:@"lproj"];
        return [NSBundle bundleWithPath:path];
    }
    return nil;
}

@end


@implementation NSBundle (XY)

+ (void)setUserLanguage:(NSString *)userLanguage{
    //跟随手机系统
    if (!userLanguage.length) {
        [self resetSystemLanguage];
        return;
    }
    //用户自定义
    [STANDARD_USER_DEFAULT setValue:userLanguage forKey:XYUserLanguageKey];
    [STANDARD_USER_DEFAULT setValue:@[userLanguage] forKey:@"AppleLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
}

+ (NSString *)userLanguage{
    return [STANDARD_USER_DEFAULT valueForKey:XYUserLanguageKey];
}

/**
 重置系统语言
 */
+ (void)resetSystemLanguage{
    [STANDARD_USER_DEFAULT removeObjectForKey:XYUserLanguageKey];
    [STANDARD_USER_DEFAULT setValue:nil forKey:@"AppleLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
}

+ (BOOL)isChineseLanguage{
    NSString *currentLanguage = [self currentLanguage];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)currentLanguage{
    return [self userLanguage] ? : [NSLocale preferredLanguages].firstObject;
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //动态继承、交换，方法类似KVO，通过修改[NSBundle mainBundle]对象的isa指针，使其指向它的子类BundleSubClass，这样便可以调用子类的方法；其实这里也可以使用method_swizzling来交换mainBundle的实现，来动态判断，可以同样实现。
        object_setClass([NSBundle mainBundle], [XYBundleSubClass class]);
    });
}

@end
