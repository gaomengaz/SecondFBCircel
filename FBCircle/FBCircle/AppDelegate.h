//
//  AppDelegate.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-6.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"//友盟


#import "WXApi.h"
#import "FBCircleUploadData.h"
#import "AFNetworkReachabilityManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>{
    
    NSDictionary *dic_push;
    
    
}

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)FBCircleUploadData * uploadData;


@end
