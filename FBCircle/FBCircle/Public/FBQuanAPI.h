//
//  Header.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-10.
//  Copyright (c) 2014年 szk. All rights reserved.
//
#pragma mark--公共类
//#import "pinyin.h"
#import "UIImageView+WebCache.h"
#import "ASIHTTPRequest.h"
#import "ZSNApi.h"
#import "FBQuanAlertView.h"
#import "EGORefreshTableHeaderView.h"

#import "ShowBigPictureViewController.h"


#ifndef FBCircle_Header_h
#define FBCircle_Header_h
//颜色

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]



#define TITLEFONT [UIFont fontWithName:@"Helvetica" size:20]
//判断屏幕
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断系统
#define MY_MACRO_NAME ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//推送的token
//#define DEVICETOKEN @"token"
//通讯录
#define ADDRESSBOOK @"addressbook"
//autherkey
#define AUTHERKEY @"autherkey"
//用户名
#define USERNAME @"username"
//用户id
#define USERID @"userid"

//用户头像

#define USERFACE @"userface"

//发表成功，刷新数据,用于通知
#define SUCCESSUPDATA @"successupdata"
//修改信息后，个人页面和fb圈刷新数据
#define UPDATAPERSONALINFORMATION @"chagePersonalInformation"
//fb圈的token
#define DEVICETOKEN @"pushdevicetoken"
//来了消息之后进行通知进入消息页面,这个是应用内的
#define COMEMESSAGES @"commessage"

//退出登录通知

#define SUCCESSLOGOUT @"successlogout"

//登陆成功通知

#define SUCCESSLOGIN @"successlogin"

//应用外来了推送用这个
#define YINGYONGWAINOTIFICATION @"wainotification"
//这个是默认图
#define   IMAGE_DEFAULT [UIImage imageNamed:@"bigImagesPlaceHolder.png"]

//
#define FBCIRCLE_DEFAULT_IMAGE [UIImage imageNamed:@"FBCircle_picture_default_new_image.png"]

#define FBCIRCLE_BACK_IMAGE [UIImage imageNamed:@"fanhui-daohanglan-20_38.png"]

#define FBCIRCLE_NAVIGATION_IMAGE [UIImage imageNamed:@"FBCircleNavBackGroundImage.png"]


//朋友列表做个缓存

#define FRIENDLISTDOCUMENT @"friendlistdocumentarray"

//短信验证码

#define MSDSENDAPI @"http://quan.fblife.com/index.php?c=interface&a=phonecode&phonenum=%@"

//获取推荐好友的接口

#define GETSUGGESTFRIENDLISTAPI @"http://quan.fblife.com/index.php?c=interface&a=getbuddy&authkey=%@==&btype=1"


//登录相关的接口
#define LOGINAPI @"http://quan.fblife.com/index.php?c=interface&a=dologin&uname=%@&upass=%@&token=%@&logtype=%d"
//注册相关的接口
#define REGISTAPI @"http://quan.fblife.com/index.php?c=interface&a=register&uname=%@&upass=%@&phone=%@&pcode=%@&email=%@&token=%@&fbtype=json"
//获取用户列表

#define GETFRIENDLIST @"http://quan.fblife.com/index.php?c=interface&a=getbuddy&authkey=%@"

//匹配通讯录的接口

#define PIPEIADDRESSBOOK @"http://quan.fblife.com/index.php?c=interface&a=getphonemember&authkey=UGQBZgNgB2MDPFA8AnkKZFIgUSwPMVVpB2VTcVprAG9SPQ==&phone=18601901680,15552499996&rname=etsfs*~^sdfafa"
//添加好友的接口

#define ADDFRIENDAPI @"http://quan.fblife.com/index.php?c=interface&a=addbuddy&authkey=%@&uid=%@&uname=%@"
//接受好友的接口

#define ACCEPTAPI @"http://quan.fblife.com/index.php?c=interface&a=confirmbuddy&authkey=%@&uid=%@"


//发表接口

#define PUBLISH_IMAGE @"http://quan.fblife.com/index.php?c=interface&a=uploadpic&authkey=%@&fbtype=json"

#define PUBLISH_IMAGE_TEXT @"http://quan.fblife.com/index.php?c=interface&a=topicpost&authkey=%@&content=%@&imageid=%@&fbtype=json"



#define PUBLISH_TEXT @"http://quan.fblife.com/index.php?c=interface&a=topicpost&authkey=%@&content=%@&fbtype=json"

//带个都有1.text 2.图片，3.地理位置

#define PUBLISH_IMAGE_TEXT_LOCATION @"http://quan.fblife.com/index.php?c=interface&a=topicpost&authkey=%@&content=%@&imageid=%@&lng=%f&lat=%f&area=%@&fbtype=json"
#define PUBLISH_TEXT_LOCATION @"http://quan.fblife.com/index.php?c=interface&a=topicpost&authkey=%@&content=%@&lng=%f&lat=%f&area=%@&fbtype=json"


#endif




//私信接口


#define MESSAGE_LIST_URL @"http://msg.fblife.com/api.php?c=index&authcode=%@"

#define MESSAGE_CHAT_URL @"http://msg.fblife.com/api.php?c=talk&touid=%@&maxid=%@&page=%d&authcode=%@"

#define MESSAGE_CHAT_SEND_MESSAGE_URL @"http://msg.fblife.com/api.php?c=send&toname=%@&&content=%@&authcode=%@&isfbring=1"



#pragma mark-FB圈接口

#define FBCIRCLE_URL @"http://quan.fblife.com/index.php?c=interface&a=getfrontpage&uid=%@&page=%d&ps=20&type=%d&fbtype=json"

#define FBCIRCLE_PRAISE_URL @"http://quan.fblife.com/index.php?c=interface&a=dopraise&authkey=%@&tid=%@&fbtype=json"

#define FBCIRCLE_COMMENT_URL @"http://quan.fblife.com/index.php?c=interface&a=doreply&authkey=%@&tid=%@&touid=%@&content=%@&fbtype=json"//发表评论的接口

#define FBCIRCLE_FORWARD_URL @"http://quan.fblife.com/index.php?c=interface&a=doforward&authkey=%@&tid=%@&touid=%@&content=%@&fbtype=json"

#define FBCIRCLE_GET_COMMENTS_URL @"http://quan.fblife.com/index.php?c=interface&a=getreplys&tid=%@&page=%d&ps=10&fbtype=json"


#define FBCIRCLE_PERSONAL_INFO_URL @"http://quan.fblife.com/index.php?c=interface&a=getuser&uid=%@&fbtype=json"


#define FBCIRCLE_SHARE_URL @"http://quan.fblife.com/index.php?c=interface&a=sharepost&content=%@&ext_title=%@&ext_image=%@&ext_link=%@&ext_content=%@&authkey=%@"


//获取头像接口

#define FBCIRCLE_PERSONAL_IMAGE_URL @"http://quan.fblife.com/index.php?c=interface&a=getuserhead&uid=%@&fbtype=json"




