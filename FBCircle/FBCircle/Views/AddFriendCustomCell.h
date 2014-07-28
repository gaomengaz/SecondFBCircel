//
//  AddFriendCustomCell.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-21.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendCustomCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imglogo;

@property(nonatomic,strong)UILabel *labeltitle;

-(void)AddFriendCustomCellSetimg:(NSString *)str_img title:(NSString *)thetitle;


@end
