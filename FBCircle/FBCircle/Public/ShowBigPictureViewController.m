//
//  ShowBigPictureViewController.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-30.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "ShowBigPictureViewController.h"

@interface ShowBigPictureViewController ()

@end

@implementation ShowBigPictureViewController

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
    
    self.title=@"大图模式";
    
    [ self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeText];
    
    
    carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64)];
    carousel.backgroundColor=[UIColor whiteColor];
    carousel.delegate=self;
    carousel.scrollOffset=10;
    carousel.dataSource=self;

    [self.view addSubview:carousel];
    
	// Do any additional setup after loading the view.
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return _array_imgurl.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    NSLog(@"%@",_array_imgurl);
    //create new view if no view is available for recycling
    if (view == nil)
    {
        UIImageView *aview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64)];
        
        NSString *str_url=[NSString stringWithFormat:@"%@",[_array_imgurl objectAtIndex:index]];
        
        while ([str_url rangeOfString:@"small"].length) {
            str_url=[str_url stringByReplacingOccurrencesOfString:@"small" withString:@"big"];
        }
        
        
        [aview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_array_imgurl objectAtIndex:index]]] placeholderImage:nil];
        
        
        view=aview;
        
    }
    
    
    //show placeholder
    
    //set image with URL. FXImageView will then download and process the image
    
    return view;
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {


//    NSArray * touchesArr=[[event allTouches] allObjects];
//    NSLog(@"手指个数%d",[touchesArr count]);
//    
// CGPoint   p1=[[touchesArr objectAtIndex:0] locationInView:self.view];
// CGPoint   p2=[[touchesArr objectAtIndex:1] locationInView:self.view];
//    
//     imageView.frame=CGRectMake(imgFrame.origin.x-addwidth/2.0f, imgFrame.origin.y-addheight/2.0f, imgFrame.size.width, imgFrame.size.height);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
