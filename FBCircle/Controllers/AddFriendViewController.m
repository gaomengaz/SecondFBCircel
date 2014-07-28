//
//  AddFriendViewController.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-14.
//  Copyright (c) 2014年 szk. All rights reserved.
//添加好友界面

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
	// Do any additional setup after loading the view.
}
-(void)loadView{
    [super loadView];
    self.view.backgroundColor=[UIColor redColor];
    _searchTab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568:480)];
    [self.view addSubview:_searchTab];
    _searchTab.delegate=self;
    _searchTab.dataSource=self;
    _searchTab.hidden=YES;
    
    //1.搜索e族的好友
    
    UIView *_searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 54)];
    _searchView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:_searchView];
    
    
    


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stridentifier=@"identifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stridentifier];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stridentifier];
        
    }
    
    //[cell setFriendAttribute:[[FriendAttribute alloc] init]];
    return cell;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
