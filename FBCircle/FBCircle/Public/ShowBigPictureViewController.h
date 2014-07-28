//
//  ShowBigPictureViewController.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-30.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iCarousel.h"



@interface ShowBigPictureViewController : MyViewController<iCarouselDelegate,iCarouselDataSource>{


    iCarousel *carousel;


}

@property(nonatomic,strong)NSArray *array_imgurl;
@end
