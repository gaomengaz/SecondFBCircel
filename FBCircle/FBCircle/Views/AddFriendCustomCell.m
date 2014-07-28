//
//  AddFriendCustomCell.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-21.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "AddFriendCustomCell.h"

@implementation AddFriendCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imglogo=[[UIImageView alloc]init];
        [self addSubview:_imglogo];
        _labeltitle=[[UILabel alloc]init];
        [self addSubview:_labeltitle];
        _labeltitle.font=[UIFont systemFontOfSize:16];
        _labeltitle.textAlignment=NSTextAlignmentLeft;
        
        
        
    }
    return self;
}

-(void)AddFriendCustomCellSetimg:(NSString *)str_img title:(NSString *)thetitle{


    _imglogo.image=[UIImage imageNamed:str_img];

    _labeltitle.text=thetitle;

}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imglogo.frame=CGRectMake(12, 12, 47, 47);
    
    _labeltitle.frame=CGRectMake(77, 23, 200, 20);
    
    


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
