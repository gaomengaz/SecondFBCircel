//
//  FriendListViewController.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-6.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "FriendListViewController.h"
#import "FriendListCell.h"
#import "FriendAttribute.h"//cell的model
#import "ZSNApi.h"
#import "AddFriendViewController.h"
#import "SuggestFriendViewController.h"
#import "GRXX4ViewController.h"


@interface FriendListViewController ()

@end

@implementation FriendListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)otherRightTypeButton:(UIButton *)sender
{
    NSLog(@"rightbutton==");
    
    AddFriendViewController *_addFriendVC=[[AddFriendViewController alloc]init];
    [self.navigationController pushViewController:_addFriendVC animated:NSYearCalendarUnit];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
// [self getmyFriendList];
    self.navigationController.navigationBarHidden=NO;
    
    
    /**
     *  上面的半透明黑条
     */
    
    
    _mainTabV.frame=CGRectMake(0, 0, 320, iPhone5?568-64:480-64);
    _searchTabV.hidden=YES;
    [arrayOfSearchResault removeAllObjects];
    [_searchTabV reloadData];
    _halfBlackV.hidden=YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.rightImageName=@"tianjiahaoyou-36_36.png";
    self.title=@"我的好友";
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeOther];
    
    myfirendListArr=[NSMutableArray array];

    
    //1
    _mainTabV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64)];
    [self.view addSubview:_mainTabV];
   [_mainTabV registerClass:[FriendListCell class] forCellReuseIdentifier:@"identifier"];

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
    
    
    __weak typeof(self) _weakself=self;
    __weak typeof(_mainTabV) _weakmaintabv=_mainTabV;

    
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
       
       [_weakself getFriendlistFromDocument];
       
       dispatch_async(dispatch_get_main_queue(), ^{
           
          
           [_weakmaintabv reloadData];
           

           [_weakself getmyFriendList];

           
       });
       
   });
//
    

    
    /**
     收到注册信息之后，刷新列表
     */
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getmyFriendList) name:GETFRIENDLIST object:nil];
    
}




#pragma mark-把搜索和进入推荐列表的放到一起作为tabV的headerView

-(void)ReceiveMytabHeaderV{

               if (!_SearchheaderV) {
            _SearchheaderV=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 115)];
            _SearchheaderV.backgroundColor=[UIColor whiteColor];

            __weak typeof(self) __weakself=self;

            //开始搜索

            _zkingSearchV=[[ZkingSearchView alloc]initWithFrame:CGRectMake(0, 12, 320, 30) imgBG:[UIImage imageNamed:@"longSearch592_60.png"] shortimgbg:[UIImage imageNamed:@"shortSearch486_60.png"]  imgLogo:[UIImage imageNamed:@""] placeholder:@"搜索好友" ZkingSearchViewBlocs:^(NSString *strSearchText, int tag) {

                [__weakself searchFriendWithname:strSearchText thetag:tag];

            }];
                   
            [_SearchheaderV addSubview:_zkingSearchV];
            UIButton *suggestFriendButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 54, 320, 94/2)];
            [_SearchheaderV addSubview:suggestFriendButton];
            [suggestFriendButton addTarget:self action:@selector(turnToSuggestFriendVC) forControlEvents:UIControlEventTouchUpInside];
            [suggestFriendButton setTitle:@"推荐好友" forState:UIControlStateNormal];
                   suggestFriendButton.titleLabel.font=[UIFont systemFontOfSize:15];
            [suggestFriendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [suggestFriendButton setImage:[UIImage imageNamed:@"tuijianhaoyou-94_94.png"] forState:UIControlStateNormal];
            [suggestFriendButton setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,160)];//上左下右
            [suggestFriendButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,185)];
            
       }
        _mainTabV.tableHeaderView= _SearchheaderV;


}

#pragma mark-搜索好友

-(void)searchFriendWithname:(NSString *)strname thetag:(int )_tag{
    //tag=1,代表取消按钮；tag=2代表开始编辑状态；tag=3代表点击了搜索按钮
    
    // self.navigationController.navigationBarHidden=YES;
    switch (_tag) {
        case 1:
        {
            NSLog(@"取消");
//            _mainTabV.scrollEnabled=YES;
            self.navigationController.navigationBarHidden=NO;
            _mainTabV.frame=CGRectMake(0, 0, 320, iPhone5?568-64:480-64);
            _searchTabV.hidden=YES;
            [arrayOfSearchResault removeAllObjects];
            [_searchTabV reloadData];
            _halfBlackV.hidden=YES;
            
        }
            break;
        case 2:
        {
            self.navigationController.navigationBarHidden=YES;
            _mainTabV.frame=CGRectMake(0, 30-7, 320, iPhone5?568-30-64+7:480-30-64+7);
            _halfBlackV.hidden=NO;
//            _mainTabV.contentOffset=CGPointMake(0, 0);
//            _mainTabV.scrollEnabled=NO;

            NSLog(@"开始编辑");
            
        }
            break;
            
        case 3:
        {
            _searchTabV.hidden=NO;
            _halfBlackV.hidden=YES;
            arrayOfSearchResault=[NSMutableArray array];
            NSLog(@"点击搜索按钮进行搜索方法");
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                
                
                
                
                
                for (FriendAttribute *_attribute in myfirendListArr) {
                    if ([_attribute.uname rangeOfString:strname].length) {
                        
                       
                        [arrayOfSearchResault addObject:_attribute];
                        
                    }
                    
                  //                    else{
//                        
//                        UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有搜索到相关好友" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                        
//                        [alertV show];
//                        
//                        
//                        
//                    }
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    if (arrayOfSearchResault.count==0) {
                        
                        UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有搜索到相关好友" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        
                        [alertV show];
                        
                    }else{
                        
                        [_searchTabV reloadData];

                    }

                    
                    
                });
                
            });
            
        }
            break;
            
            
        default:
            break;
    }
    
    
}
#pragma mark--进入推荐好友的界面

-(void)turnToSuggestFriendVC{
    
    SuggestFriendViewController *_matchingVC=[[SuggestFriendViewController alloc]init];
    _matchingVC.str_title=@"推荐好友";
    [self.navigationController pushViewController:_matchingVC animated:YES];
    
}
#pragma mark--tableviewdelegateAndDatesource


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
        
        return 27;

    }else{
    
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_mainTabV) {
         NSInteger count=[[arrayinfoaddress objectAtIndex:section] count];
        NSLog(@"count.....%d",count);
        return count;
    }else
    
    {
        NSInteger count=[arrayOfSearchResault count];
        return count;

    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stridentifier=@"identifier";
    
    FriendListCell *cell=[tableView dequeueReusableCellWithIdentifier:stridentifier];
    
    if (!cell) {
        
        cell=[[FriendListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stridentifier];
    }
    if (tableView==_mainTabV) {
        
        FriendAttribute *_model=[[arrayinfoaddress objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        [cell setFriendAttribute:_model];
        
    }else{
        
        FriendAttribute *_model=[arrayOfSearchResault objectAtIndex:indexPath.row];
        
        [cell setFriendAttribute:_model];
    }
    
    return cell;
}

-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView==_mainTabV) {
        NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
        for(char c = 'A';c<='Z';c++)
            [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
        return toBeReturned;

    }else{
        return nil;
    
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_mainTabV) {
        if ([[arrayinfoaddress objectAtIndex:section] count]==0) {
            return 0;
        }else{
            return 25;
        }
        
    }else{
    
        return 0;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    UIView *aview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];

    if (tableView==_mainTabV) {
        aview.backgroundColor=[UIColor whiteColor];
        
        UIView *lingV=[[UIView alloc]initWithFrame:CGRectMake(12, 24.5, 320-24, 0.5)];
        lingV.backgroundColor=RGBCOLOR(225, 225, 225);
        [aview addSubview:lingV];
        
        
        UIView *lingV2=[[UIView alloc]initWithFrame:CGRectMake(12,0, 320-24, 0.5)];
        lingV2.backgroundColor=RGBCOLOR(225, 225, 225);
        [aview addSubview:lingV2];
        
        UILabel *_label=[[UILabel alloc]initWithFrame:CGRectMake(12, 0.5, 320-24, 24)];
        
        _label.text=[NSString stringWithFormat:@"    %c",'A'+section];
        
        _label.backgroundColor=[UIColor grayColor];
        
        _label.backgroundColor=RGBCOLOR(250, 250, 250);
        
        [aview addSubview:_label];
    }else{
        aview=nil;
    }

    
    return aview;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (tableView==_mainTabV) {
//        return 0;
//
//    }else{
//        return 0;
//    
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView==_mainTabV) {
        
        
        NSInteger count = 0;
        for(NSString *character in arrayOfCharacters)
        {
            if([character isEqualToString:title])
            {
                return count;
            }
            count ++;
        }
       
        return count;

    }else{
    
    
        return 0;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];


    if (tableView==_mainTabV) {
        
        
        
        
        FriendAttribute *_model=[[arrayinfoaddress objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        GRXX4ViewController *_grc=[[GRXX4ViewController alloc]init];
        _grc.passUserid=_model.uid;
        [self.navigationController pushViewController:_grc animated:YES];
    }else{
        
        
        FriendAttribute *_model=[arrayOfSearchResault  objectAtIndex:indexPath.row];
        GRXX4ViewController *_grc=[[GRXX4ViewController alloc]init];
        _grc.passUserid=_model.uid;
        [self.navigationController pushViewController:_grc animated:YES];

    
    }
 }
/**
 删除好友操作
 */
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//       // [_dataArray removeObjectAtIndex:indexPath.row];
//        
//       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
//

#pragma mark--将通讯录保存一下

-(void)getFriendlistFromDocument{
    
    
    
    NSUserDefaults *standUser=[NSUserDefaults standardUserDefaults];
    NSArray *theArrInfo=[NSArray array];
    [myfirendListArr removeAllObjects];
    theArrInfo=[standUser objectForKey:GETFRIENDLIST];
    
    if (theArrInfo.count==0) {
        
        NSLog(@"没有数据，走网络");
       // [self getmyFriendList];
    }else{
        
        
        NSLog(@"有数据，走缓存");
        
        
        for (int i=0; i<theArrInfo.count; i++) {
            NSDictionary *dic=[theArrInfo objectAtIndex:i];
            FriendAttribute *model=[[FriendAttribute alloc] init];
            
            [model setFriendAttributeDic:dic];
            [myfirendListArr addObject:model];
            
        }
        [self documentTestwhat];
        
        
    }
    
    
    
}

#pragma mark---得到网络数据后在这里处理成有二维数组


-(void)testwhat{
    
    
    
    arrayOfCharacters=[NSMutableArray array];
    
    for (char c='A'; c<'Z'; c++) {
        [arrayOfCharacters addObject:[NSString stringWithFormat:@"%c",c]];
    }
    [arrayOfCharacters addObject:[NSString stringWithFormat:@"%@",@"#"]];
    
    arrayname=[NSMutableArray array];
    
    
    arrayinfoaddress=[ZSNApi exChangeFriendListByOrder:myfirendListArr];
    
    
   [_mainTabV reloadData];
    NSLog(@"arrayinfo===%@",arrayinfoaddress);
    
}

-(void)documentTestwhat{

    
    arrayOfCharacters=[NSMutableArray array];
    
    for (char c='A'; c<'Z'; c++) {
        [arrayOfCharacters addObject:[NSString stringWithFormat:@"%c",c]];
    }
    [arrayOfCharacters addObject:[NSString stringWithFormat:@"%@",@"#"]];
    
    arrayname=[NSMutableArray array];
    
    
    arrayinfoaddress=[ZSNApi exChangeFriendListByOrder:myfirendListArr];
    

}

#pragma mark--获取好友列表

-(void)getmyFriendList{
    

    
    __weak typeof(self) weakself=self;
    
    SzkLoadData *_loadRegist=[[SzkLoadData alloc]init];
    NSString *str_url=[NSString stringWithFormat:GETFRIENDLIST,[SzkAPI getAuthkey]];
    
    [_loadRegist SeturlStr:str_url block:^(NSArray *arrayinfo, NSString *errorindo, int errcode) {
        
        [weakself successLoaddataWithArr:arrayinfo errcode:errcode errorinfo:errorindo];
        
        
        
        
    }];
    
    
    NSLog(@"获取好友列表的接口%@",str_url);
    
}
#pragma mark-获取到好友列表之后，刷新tableview

-(void)successLoaddataWithArr:(NSArray *)theArrInfo errcode:(int)theerrcode errorinfo:(NSString *)theerrinfo{

    
    
    if (theerrcode==0) {
        
        [myfirendListArr removeAllObjects];
        [_mainTabV reloadData];
        /**
         *  将请求的网络数组保存到本地
         */
        NSUserDefaults *standdardUser=[NSUserDefaults standardUserDefaults];
        [standdardUser setObject:theArrInfo forKey:GETFRIENDLIST];
        [standdardUser synchronize];
        
        for (int i=0; i<theArrInfo.count; i++) {
            NSDictionary *dic=[theArrInfo objectAtIndex:i];
            FriendAttribute *model=[[FriendAttribute alloc] init];
            
            [model setFriendAttributeDic:dic];
            [myfirendListArr addObject:model];
            
        }
        [self testwhat];
        
    }else{
        
        if (theerrcode==1) {
            //
            //                UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"现在没有好友哦，赶紧点击右上角添加吧！"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //                [alertV show];
            return ;
            
        }
        
        
        UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"获取好友列表失败，原因：%@",theerrinfo] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
