//
//  WritePreviewDeleteViewController.h
//  FBCircle
//
//  Created by soulnear on 14-5-19.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBShowImagesScrollView.h"


typedef void(^PreViewDeleteBlock)(int currentPage);


@interface WritePreviewDeleteViewController : UIViewController<QBShowImagesScrollViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    UIView * navgationBar;
        
    UIButton * chooseButton;
    
    char identifier[20];
    
    UILabel * title_label;
    
    UIView * navImageView;
    
    PreViewDeleteBlock preViewBlock;
}


@property(nonatomic,strong)UIScrollView * myScrollView;

@property(nonatomic,assign)int currentPage;

@property(nonatomic,strong)NSMutableArray * AllImagesArray;

@property(nonatomic,assign)int SelectedCount;


-(void)deleteSomeImagesWithBlock:(PreViewDeleteBlock)theBlock;


@end
