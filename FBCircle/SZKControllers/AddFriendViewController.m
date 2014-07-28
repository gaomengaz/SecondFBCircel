//
//  AddFriendViewController.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-14.
//  Copyright (c) 2014年 szk. All rights reserved.
//添加好友界面

#import "AddFriendViewController.h"
#import "AddFriendCustomCell.h"
#import "ZkingSearchView.h"
#import "SMSInvitationViewController.h"//短信邀请


#import "GRXX4ViewController.h"//各种情况 好友 非好友 自己 正在验证中的好友

#import "MatchingAddressBookViewController.h"

@interface AddFriendViewController (){
 NSArray *array_title;
    NSArray *array_logoimg;
}

@end

@implementation AddFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _scene = WXSceneSession;

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    
    [super viewWillAppear:YES];

    self.navigationController.navigationBarHidden=!_searchTabV.hidden;
    [_mainTabV reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isnavgationBarhiden=YES;
    
    array_title=[NSArray arrayWithObjects:@"从手机通讯录添加",@"通过微信",@"通过短信", nil];
    array_logoimg=[NSArray arrayWithObjects:@"tongxunlu-icon-94_94.png",@"weixin-icon-94_94.png",@"duanxin-icon-94_94.png", nil];

    _array_searchResault=[NSArray array];
      self.title=@"添加好友";
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
	// Do any additional setup after loading the view.
}
-(void)loadView{
    [super loadView];

    //1
    _mainTabV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568:480)];
    [self.view addSubview:_mainTabV];
    _mainTabV.delegate=self;
    _mainTabV.separatorColor=RGBCOLOR(225, 225, 225);
    _mainTabV.dataSource=self;
    //2
    _searchTabV=[[UITableView alloc]initWithFrame:CGRectMake(0, 75, 320, iPhone5?568-75:480-75)];
    [self.view addSubview:_searchTabV];
    _searchTabV.delegate=self;
    _searchTabV.separatorColor=RGBCOLOR(225, 225, 225);
    _searchTabV.dataSource=self;
    _searchTabV.hidden=YES;
    //3
    _halfBlackV=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 320, iPhone5?568-75:480-75)];
    _halfBlackV.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8];
    _halfBlackV.hidden=YES;
    [self.view addSubview:_halfBlackV];
    [self ReceiveMytabHeaderV];//加上tab的headerv
    
    
    UIView *heitiao=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 6)];
    heitiao.backgroundColor=RGBACOLOR(220, 220, 220, 0.7);
    [self.view addSubview:heitiao];

}


#pragma mark-把搜索和进入推荐列表的放到一起作为tabV的headerView
-(void)ReceiveMytabHeaderV{
    
    UIView *aviews=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,54)];
        
        __weak typeof(self) __weakself=self;
        
        //开始搜索
        
    ZkingSearchView * _zkingSearchV=[[ZkingSearchView alloc]initWithFrame:CGRectMake(0, 12, 320, 30) imgBG:[UIImage imageNamed:@"longSearch592_60.png"] shortimgbg:[UIImage imageNamed:@"shortSearch486_60.png"]  imgLogo:[UIImage imageNamed:@""] placeholder:@"搜索好友" ZkingSearchViewBlocs:^(NSString *strSearchText, int tag) {
            
            [__weakself searchFriendWithname:strSearchText thetag:tag];
            
        }];
    [aviews addSubview:_zkingSearchV];
        
     _mainTabV.tableHeaderView= aviews;
    
    
}
-(void)searchFriendWithname:(NSString *)strname thetag:(int )_tag{
    //tag=1,代表取消按钮；tag=2代表开始编辑状态；tag=3代表点击了搜索按钮
    
    // self.navigationController.navigationBarHidden=YES;
    switch (_tag) {
        case 1:
        {
            NSLog(@"取消");
            self.navigationController.navigationBarHidden=NO;
            _mainTabV.frame=CGRectMake(0, 0, 320, iPhone5?568:480);
            _searchTabV.hidden=YES;
//            [arrayOfSearchResault removeAllObjects];
            [_searchTabV reloadData];
            _halfBlackV.hidden=YES;
            
        }
            break;
        case 2:
        {
            self.navigationController.navigationBarHidden=YES;
            _mainTabV.frame=CGRectMake(0, 30-7, 320, iPhone5?568-30+7:480-30+7);
            _halfBlackV.hidden=NO;
            NSLog(@"开始编辑");
            
        }
            break;
            
        case 3:
        {
            
            _searchTabV.hidden=NO;
            _halfBlackV.hidden=YES;
            NSLog(@"点击搜索按钮进行搜索方法");
            _array_searchResault =[NSArray array];
            [_searchTabV reloadData];
            __weak typeof(_searchTabV) weaksearchtab=_searchTabV;
            SzkLoadData *loaddata=[[SzkLoadData alloc]init];
            
            NSString *str_search=[NSString stringWithFormat:@"http://quan.fblife.com/index.php?c=interface&a=searchuser&keyword=%@",[strname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSLog(@"搜索的接口是这个。。=%@",str_search);
            
            
            [loaddata SeturlStr:[NSString stringWithFormat:@"http://quan.fblife.com/index.php?c=interface&a=searchuser&keyword=%@&authkey=%@",[strname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[SzkAPI getAuthkey]] block:^(NSArray *arrayinfo, NSString *errorindo, int errcode)
             {
                if(errcode==0)
                {
                    _array_searchResault=arrayinfo;
                    
                    [weaksearchtab reloadData];

                }else{
                
                
                    UIAlertView *_alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:errorindo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [_alertV show];
                
                
                }
                           NSLog(@"errcode==%d===%@",errcode,arrayinfo);
                NSLog(@"errcode==%d===%@",errcode,_array_searchResault);

            }];
            
        }
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark-tableview的代理


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_mainTabV) {
        if (_mainTabV.frame.origin.y!=0) {
            
            _mainTabV.contentOffset=CGPointMake(0, 0);
            
        }else{
            
        }
        
        
        
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView==_mainTabV) {
        return 2;
        
    }else{
        return 1;

    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger number=0;
    if (tableView==_mainTabV) {
        number=section==0?1:2;
    }else{
        number=_array_searchResault.count;
    }
    return number;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_mainTabV) {
        
        static NSString *stridentifier=@"identifier";
        
        AddFriendCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:stridentifier];
        
        if (!cell) {
            cell=[[AddFriendCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stridentifier];
            
        }
        
        if (indexPath.row==0) {
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }else{
            cell.selectionStyle=UITableViewCellSelectionStyleGray;

        }
       
        [cell AddFriendCustomCellSetimg:[array_logoimg objectAtIndex:indexPath.section+indexPath.row] title:[array_title objectAtIndex:indexPath.section+indexPath.row]];
        
        //[cell setFriendAttribute:[[FriendAttribute alloc] init]];
        return cell;

        
    }else{
        static NSString *stridentifier=@"identifier";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stridentifier];
        
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stridentifier];
            
        }
        
        @try {
            
            NSDictionary *dic__=[_array_searchResault objectAtIndex:indexPath.row];
            
            cell.textLabel.text=[dic__ objectForKey:@"username"];

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }

        //[cell setFriendAttribute:[[FriendAttribute alloc] init]];
        return cell;

    
    
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 71;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (tableView==_mainTabV) {
        if (section==0) {
            return nil;
        }else{
            
            UIView *aview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
            UILabel *label_aha=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, 320-24, 25)];
            [aview addSubview:label_aha];
            label_aha.text=@"   邀请好友";
            label_aha.textAlignment=NSTextAlignmentLeft;
            label_aha.font=[UIFont systemFontOfSize:13];
            label_aha.backgroundColor=RGBCOLOR(250, 250, 250);
            
            return aview;
            
        }
    }else{
    
        return nil;
    }


}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (tableView==_mainTabV) {
        return section==0?0:25;

    }else{
        return 0;
    
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];

    
    
    if (tableView==_mainTabV) {
        if (indexPath.section==0) {
            NSLog(@"跳转到通讯录匹配");
            MatchingAddressBookViewController *suggestVC=[[MatchingAddressBookViewController alloc]init];
            suggestVC.str_title=@"从手机通讯录添加";
            [self.navigationController pushViewController:suggestVC animated:YES];
            
        }else{
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"跳转到微信");
                    
                    [self sendLinkContent];
                }
                    break;
                case 1:
                {
                    NSLog(@"跳转到短信");
                    
                    SMSInvitationViewController *_smsVC=[[SMSInvitationViewController alloc]init];
                    [self.navigationController pushViewController:_smsVC animated:YES];

                }
                    break;
     
                default:
                    break;
            }
        
        
        }
    }
    else{
    
        @try {
            
            
            /**
             *  1好友 2添加中 3接到邀请 4本人  5 没关系

             */
         
//            int thetype=[[[_array_searchResault objectAtIndex:indexPath.row] objectForKey:@"friendtype"] integerValue];
//            if (thetype==1) {
//                GRXX2ViewController *_grc=[[GRXX2ViewController alloc]init];
//                _grc.userid=[[_array_searchResault objectAtIndex:indexPath.row] objectForKey:@"uid"];
//                [self.navigationController pushViewController:_grc animated:YES];
//
//            }else if (thetype==2||thetype==3||thetype==5){
//                GRXX3ViewController *_grc=[[GRXX3ViewController alloc]init];
//                _grc.userid=[[_array_searchResault objectAtIndex:indexPath.row] objectForKey:@"uid"];
//                [self.navigationController pushViewController:_grc animated:YES];
//                
//            }
//            
//            else{
                GRXX4ViewController *_grc=[[GRXX4ViewController alloc]init];
              _grc.passUserid=[[_array_searchResault objectAtIndex:indexPath.row] objectForKey:@"uid"];
                [self.navigationController pushViewController:_grc animated:YES];
                
//            }
            
        }
        @catch (NSException *exception) {
        
        }
        @finally {
            
        }
        
  
    }

}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
//}

- (void) sendLinkContent
{
    WXMediaMessage *message = [WXMediaMessage message];
   // message.title = @"ss";
    message.description =[NSString stringWithFormat:@"你越野e族的朋友%@邀请你加入FB圈,https://quan.fb.cn/download",[SzkAPI getUsername]];
    [message setThumbImage:[UIImage imageNamed:@"res2.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"https://quan.fb.cn/download";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
