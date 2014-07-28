//
//  MessageViewController.m
//  FBCircle
//
//  Created by soulnear on 14-5-19.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize myTableView = _myTableView;
@synthesize theModel = _theModel;
@synthesize data_array = _data_array;
@synthesize system_notification_dictionary = _system_notification_dictionary;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        theTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(checkallmynotification) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)loadMessageData
{
    typeof(self) bself = self;
    
    [_theModel loadInfomationWithBlock:^(NSMutableArray *array)
     {
         bself.data_array = [NSMutableArray arrayWithArray:array];
         
         [bself.myTableView reloadData];
     }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的消息";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    isnewfbnotification = [[NSUserDefaults standardUserDefaults] boolForKey:@"systemMessageRemind"];
    
//    NSLog(@"system ---   %@",_system_notification_dictionary);
//    if ([[_system_notification_dictionary allKeys] containsObject:@"message"])
//    {
//        isnewfbnotification = YES;
//    }
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,6,320,(iPhone5?568:480)-20-44-6) style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    self.myTableView.rowHeight = 60;
    
    self.myTableView.separatorInset = UIEdgeInsetsZero;
    
    [self.view addSubview:self.myTableView];
    
    _theModel = [[MessageModel alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadMessageData];
}



#pragma mark-UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data_array.count + 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    CustomMessageCell * cell = (CustomMessageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[CustomMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.headImageView.image = nil;
    cell.NameLabel.text = @"";
    cell.timeLabel.text = @"";
    cell.contentLabel1.text = @"";
    cell.contentLabel.text = @"";
    
    if (indexPath.row ==0)
    {
        cell.tixing_label.image = nil;
        
        [cell setAllViewWithType:1];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.contentLabel.text = @"系统通知";
        
        cell.headImageView.image = [UIImage imageNamed:@"xiaoxi_80_80.png"];
        
        cell.tixing_label.hidden=NO;
        
        
        if (!_tixing_label)
        {
            _tixing_label = [[UIImageView alloc] init];
            
            _tixing_label.layer.masksToBounds = YES;
            
            _tixing_label.layer.cornerRadius = 3.5;
            
            _tixing_label.backgroundColor = RGBACOLOR(245,6,0,1);
            
        }
        
        _tixing_label.hidden = !isnewfbnotification;
        
        _tixing_label.frame=CGRectMake(120, 21,7,7);
        
        _tixing_label.center = CGPointMake(50,10);
        
        [cell.contentView addSubview:_tixing_label];
    }else
    {
        cell.tixing_label.hidden = YES;
        
        MessageModel * model = [_data_array objectAtIndex:indexPath.row-1];
        
        [cell setAllViewWithType:0];
        
        [cell setInfoWithType:0 withMessageInfo:model];
    }
    
    UIColor *color = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
    cell.selectedBackgroundView.backgroundColor =color;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"readMessageNotification" object:nil];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"systemMessageRemind"];
        
        GmyMessageViewController * messageVC = [[GmyMessageViewController alloc] init];
        
        isnewfbnotification = NO;
        
        [self.navigationController pushViewController:messageVC animated:YES];
    }else
    {
        MessageModel * model = [self.data_array objectAtIndex:indexPath.row-1];
        
        ChatViewController * chatViewController = [[ChatViewController alloc] init];
        
        chatViewController.messageInfo = model;
        
        chatViewController.otherHeaderImage = model.otherFaceImage;
        
        [self.navigationController pushViewController:chatViewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


-(void)checkallmynotification
{
    NSString * fullUrl =[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",[SzkAPI getAuthkey]];
    
    NSLog(@"私信列表页------%@",fullUrl);
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    AFHTTPRequestOperation * opration = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    __block AFHTTPRequestOperation * request = opration;
    
    [request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        @try
        {
            NSDictionary *dic=[opration.responseString objectFromJSONString];
            
               int NewsMessageNumber = 0;
                
                NSDictionary * alertnum_dic = [dic objectForKey:@"alertnum"];
                
            NSLog(@"alertnum   ----   %@",alertnum_dic);
                for (int i = 0;i <= 16;i++)
                {
                    if (i == 6)
                    {
                        if ([[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue]>0)
                        {
                            typeof(self) bself = self;
                            
                            [_theModel loadInfomationWithBlock:^(NSMutableArray *array)
                             {
                                 bself.data_array = [NSMutableArray arrayWithArray:array];
                                 
                                 [bself.myTableView reloadData];
                             }];
                        }
                    }else
                    {
                        NewsMessageNumber += [[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue];
                    }
                }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [opration start];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end










