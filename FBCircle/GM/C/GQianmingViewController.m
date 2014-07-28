//
//  GQianmingViewController.m
//  FBCircle
//
//  Created by gaomeng on 14-5-26.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "GQianmingViewController.h"

#import "GRXX4ViewController.h"

@interface GQianmingViewController ()

@end

@implementation GQianmingViewController


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    
    self.navigationItem.title = @"个性签名";
    
    self.rightString = @"保存";
    [self setMyViewControllerLeftButtonType:(MyViewControllerLeftbuttonTypeBack) WithRightButtonType:MyViewControllerRightbuttonTypeText];
    
    UIView *heitiao=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 6)];
    heitiao.backgroundColor=RGBACOLOR(220, 220, 220, 0.7);
    [self.view addSubview:heitiao];
    
    
    

    if (self.yuanlaiQianming.length>0) {
        _gholderTextView = [[GHolderTextView alloc]initWithFrame:CGRectMake(16, 10, 288, 200) placeholder:nil holderSize:15];
        _gholderTextView.text = self.yuanlaiQianming;//以前的签名
    }else{
        _gholderTextView = [[GHolderTextView alloc]initWithFrame:CGRectMake(16, 10, 288, 200) placeholder:@"心情记录..." holderSize:15];
    }
   
    _gholderTextView.font = [UIFont systemFontOfSize:15];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 320, 210)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];

    [self.view addSubview:_gholderTextView];
    [_gholderTextView becomeFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







//重写父类的方法


-(void)submitData:(UIButton *)sender
{
    NSLog(@"保存  设置用户上传个性签名");
    
    
    SzkLoadData *_test=[[SzkLoadData alloc]init];
    
    
    NSString * qm = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)_gholderTextView.text, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    NSString *str = [NSString stringWithFormat:@"http://quan.fblife.com/index.php?c=interface&a=updateuserinfo&optype=words&authkey=%@==&words=%@",[SzkAPI getAuthkey],qm];
    
    
    //get
    
    [_test SeturlStr:str block:^(NSArray *arrayinfo, NSString *errorindo, int errcode) {
        
        if (errcode==0) {
            NSLog(@"成功");
            
            //发通知
            [[NSNotificationCenter defaultCenter]postNotificationName:@"chagePersonalInformation" object:nil];
            
        }else{
            NSLog(@"xxssx===%@",arrayinfo);
        }
        
    }];
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}





@end
