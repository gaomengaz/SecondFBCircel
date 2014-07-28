//
//  AppDelegate.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-6.
//  Copyright (c) 2014年 szk. All rights reserved.
//a

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MainViewController.h"//中心的viewc
#import "LeftViewController.h"//侧滑到左边的，暂时用不到
#import "RightViewController.h"//侧滑到右边的，暂时用不到
#import "WriteBlogViewController.h"
#import "GpersonallSettingViewController.h"

#import "pinyin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    int cacheSizeMemory = 4*1024*1024; // 4MB
    int cacheSizeDisk = 32*1024*1024; // 32MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    _uploadData = [[FBCircleUploadData alloc] init];
    
    MainViewController *_MainVC=[[MainViewController alloc]init];
    _MainVC.edgesForExtendedLayout = UIRectEdgeNone;
    UINavigationController * _MainNaVC = [[UINavigationController alloc] initWithRootViewController:_MainVC];
    
    
    GpersonallSettingViewController *_LeftVC=[[GpersonallSettingViewController alloc]init];
    //  RightViewController *_RightVC=[[RightViewController alloc]init];
    
    UINavigationController * _ln = [[UINavigationController alloc] initWithRootViewController:_LeftVC];
    //  UINavigationController * _rn = [[UINavigationController alloc] initWithRootViewController:_RightVC];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    MMDrawerController *_RootVC=[[MMDrawerController alloc]initWithCenterViewController:_MainNaVC leftDrawerViewController:nil rightDrawerViewController:nil];
    
    
    [_RootVC setMaximumRightDrawerWidth:200];
    [_RootVC setMaximumLeftDrawerWidth:320];
    _RootVC.shouldStretchDrawer = NO;
    [_RootVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_RootVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    [MobClick startWithAppkey:@"5368ab4256240b6925029e29"];
    
    //微信
    [WXApi registerApp:@"wx278bfca281b3cfd1"];
    
    
    
    //  WriteBlogViewController * writeVC = [[WriteBlogViewController alloc] init];
    //  UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:writeVC];
    self.window.rootViewController=_RootVC;
    
    /**
     *  pushStart,必须在self.window.rootViewController设置后再搞
     */
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    if (launchOptions) {
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey) {
            
            // [alert show];
            dic_push =[[NSDictionary alloc]initWithDictionary:pushNotificationKey];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:YINGYONGWAINOTIFICATION object:self userInfo:dic_push];
            
            /*
             
             小红点的位置及大小找王晴要要图
             应用外的操作
             *  转发，评论，赞直接进高猛写的消息列表页面
             接受和申请好友的进推荐好友ps:推荐好友页面要换，后台需要按时间排出来
             私信的跳到私信列表页面
             */
            
            
            
            //
            //            UIAlertView *_alert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",dic_push] delegate:nil cancelButtonTitle:@"launchOptions" otherButtonTitles:nil, nil];
            //            [_alert show];
            
        }
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"testpush" object:dic_push];
    
    
    
    /**
     *  pushEnd
     */
    
    
    
    
    
    
    
    //判断网络是否可用
    //开启监控
    //[[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    AFNetworkReachabilityManager *afnrm =[AFNetworkReachabilityManager sharedManager];
    [afnrm startMonitoring];
    //设置网络状况监控后的代码块
    [afnrm setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch ([[AFNetworkReachabilityManager sharedManager]networkReachabilityStatus]) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                [_uploadData upload];
                [_uploadData uploadBannerAndFace];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"WWAN");
                [_uploadData upload];
                [_uploadData uploadBannerAndFace];
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"Unknown");
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"NotReachable");
                
                break;
            default:
                break;
        }
    }];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

#pragma mark-微信的
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [WXApi handleOpenURL:url delegate:self];
    
    
}
-(void) onResp:(BaseResp*)resp
{
    
    
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        if (resp.errCode==0) {
            strMsg=@"邀请成功";
        }else{
            
            strMsg=@"邀请失败";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。

#pragma mark-Push

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    //
    //    UIAlertView *_alert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",userInfo] delegate:nil cancelButtonTitle:@"靠谱" otherButtonTitles:nil, nil];
    //    [_alert show];
    /**
     *  应用内的操作
     转发、评论、赞的还是像先前一样显示，这个右上角也有红点
     好友相关的，来了消息之后人头的右上角加红点
     私信的也是右上角有红点
     红点的消失与下个界面有关系
     
     */
    
    [[NSNotificationCenter defaultCenter]postNotificationName:COMEMESSAGES object:self userInfo:userInfo];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    /**
     这里收到了信息
     */
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSLog(@"My token is: %@", deviceToken);
    
    
    NSString *string_pushtoken=[NSString stringWithFormat:@"%@",deviceToken];
    
    while ([string_pushtoken rangeOfString:@"<"].length||[string_pushtoken rangeOfString:@">"].length||[string_pushtoken rangeOfString:@" "].length) {
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@"<" withString:@""];
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@">" withString:@""];
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:string_pushtoken forKey:DEVICETOKEN];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    
    
    NSLog(@"Failed to get token, error: %@", error);
}



#pragma mark - 上传的代理回调方法
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"上传完成");
    
    if (request.tag == 123)//上传用户头像
    {
        NSLog(@"走了555");
        NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[request.responseData objectFromJSONData]];
        NSLog(@"tupiandic==%@",dic);
        
        
        
        
        if ([[dic objectForKey:@"errcode"]intValue] == 0) {
            NSString *str = @"no";
            [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"gIsUpFace"];
            
        }else{
            NSString *str = @"yes";
            [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"gIsUpFace"];
        }
        
        
        //发通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"chagePersonalInformation" object:nil];
        
    }else if (request.tag == 122)//上传用户banner
    {
        NSLog(@"走了555");
        NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[request.responseData objectFromJSONData]];
        
        NSLog(@"tupiandic==%@",dic);
        
        if ([[dic objectForKey:@"errcode"]intValue] == 0) {
            NSLog(@"上传成功");
            NSString *str = @"no";
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"gIsUpBanner"];
            
        }else{
            NSString *str = @"yes";
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"gIsUpBanner"];
            
        }
        
        
        //发通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"chagePersonalInformation" object:nil];
        
    }
    
}




#pragma mark-系统的

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
