//
//  NYHAppDelegate.m
//  SpeechAndShared
//
//  Created by FXTX-iOS on 14-8-27.
//  Copyright (c) 2014年 FXTX-iOS. All rights reserved.
//

// By NYH 
#import "NYHAppDelegate.h"
#import "NYHMainViewController.h"

// 语音模块
#import "iflyMSC/IFlySpeechUtility.h"
#define IFLY_APP_ID @"53fd7a30"

// 分享模块
#import "UMSocial.h"
#define UM_APP_KEY @"53fe8661fd98c5cf0400da7c"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialTencentWeiboHandler.h"
//#import "UMSocialRenrenHandler.h"
//#import "UMSocialQQHandler.h"    // 64位系统暂不支持


@implementation NYHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 语音
    [self setSpeech];
    
    // 分享
    [self setShared];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.mainViewController = [[NYHMainViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:self.mainViewController];
    self.window.rootViewController = navi;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

// 语音模块
- (void)setSpeech
{
    // 创建语音配置  注意：出现问题，是编译器的问题：32位和64位不一样
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",IFLY_APP_ID];
    
    // 所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
}


// 分享模块
- (void)setShared
{
    [UMSocialData setAppKey:UM_APP_KEY];
    
    //设置微信AppId，url地址传nil，将默认使用友盟的网址，需要#import "UMSocialWechatHandler.h"
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];

    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //打开腾讯微博SSO开关，设置回调地址
    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];

//    //打开人人网SSO开关
//    [UMSocialRenrenHandler openSSO];
//    
//    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    //设置支持没有客户端情况下使用SSO授权
//    [UMSocialQQHandler setSupportWebView:YES];
}


// 系统回调方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


//// 若除了使用我们SDK外，还用了其他SDK，需要重写此回调方法的，可以参考下面的写法：
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如新浪微博SDK等
//    }
//    return result;
//}



@end
