//
//  FriendListCell.h
//  FBCircle
//
//  Created by 史忠坤 on 14-5-13.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendAttribute.h"

@interface FriendListCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headImageV;


@property (nonatomic,strong)UILabel  *nameLabel;

-(void)setFriendAttribute:(FriendAttribute *)FriendAttributemodel;


@end
