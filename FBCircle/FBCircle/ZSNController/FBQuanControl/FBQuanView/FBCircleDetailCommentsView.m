//
//  FBCircleDetailCommentsView.m
//  FBCircle
//
//  Created by soulnear on 14-5-22.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "FBCircleDetailCommentsView.h"

@implementation FBCircleDetailCommentsView
@synthesize delegate = _delegate;
@synthesize headerImageView = _headerImageView;
@synthesize userName_label = _userName_label;
@synthesize dateLine_label = _dateLine_label;
@synthesize content_label = _content_label;
@synthesize upLine_view = _upLine_view;
@synthesize bottomLine_view = _bottomLine_view;
@synthesize left_view = _left_view;
@synthesize right_view = _right_view;
@synthesize pinglun_logo = _pinglun_logo;


//297.5
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.clipsToBounds = YES;
        
        self.backgroundColor =  RGBCOLOR(249,249,249);
        
        
        if (!_pinglun_logo) {
            _pinglun_logo = [[UIImageView alloc] initWithFrame:CGRectMake(22.5,20,14,14)];
            
            _pinglun_logo.image = [UIImage imageNamed:@"pinglun_28_28.png"];
            
            [self addSubview:_pinglun_logo];
        }
        
        
        if (!_headerImageView)
        {
            _headerImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(44,8,35,35)];
            
            _headerImageView.layer.cornerRadius = 5;
            
            _headerImageView.layer.masksToBounds = YES;
            
            _headerImageView.userInteractionEnabled = YES;
            
            _headerImageView.backgroundColor = [UIColor clearColor];
            
            [self addSubview:_headerImageView];
            
            
            UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)];
            
            [_headerImageView addGestureRecognizer:headerTap];
            
        }
        
        
        if (!_userName_label) {
            _userName_label = [[UILabel alloc] initWithFrame:CGRectMake(89,8,110,15)];
            
            _userName_label.textAlignment = NSTextAlignmentLeft;
            
            _userName_label.textColor = RGBCOLOR(72,145,57);
            
            _userName_label.font = [UIFont systemFontOfSize:14];
            
            _userName_label.backgroundColor = [UIColor clearColor];
            
            [self addSubview:_userName_label];
        }
        
        if (!_dateLine_label) {
            _dateLine_label = [[UILabel alloc] initWithFrame:CGRectMake(201,8,100,14)];
            
            _dateLine_label.textAlignment = NSTextAlignmentRight;
            
            _dateLine_label.textColor = RGBCOLOR(120,120,120);
            
            _dateLine_label.font = [UIFont systemFontOfSize:12];
            
            _dateLine_label.backgroundColor = [UIColor clearColor];
            
            [self addSubview:_dateLine_label];
        }
        
        if (!_content_label) {
            _content_label = [[RTLabel alloc] initWithFrame:CGRectMake(89,31,212,0)];
            
            _content_label.textAlignment = NSTextAlignmentLeft;
            
            _content_label.lineBreakMode = NSLineBreakByCharWrapping;
            
            _content_label.lineSpacing = 3;
            
            _content_label.font = [UIFont systemFontOfSize:14];
            
            _content_label.backgroundColor = [UIColor clearColor];
            
            [self addSubview:_content_label];
        }
        //506
        
        if (!_upLine_view)
        {
            _upLine_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,0)];
            
            _upLine_view.backgroundColor = RGBCOLOR(215,215,215);
            
            [self addSubview:_upLine_view];
        }
        
        if (!_bottomLine_view)
        {
            _bottomLine_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0.5)];
            
            _bottomLine_view.backgroundColor = RGBCOLOR(237,237,237);
            
            _bottomLine_view.hidden = YES;
            
            [self addSubview:_bottomLine_view];
        }
        
//        if (!_left_view)
//        {
//            _left_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,0.5,0)];
//            
//            _left_view.backgroundColor = RGBCOLOR(237,237,237);
//            
//            [self addSubview:_left_view];
//        }
//        
//        
//        if (!_right_view)
//        {
//            _right_view = [[UIView alloc] initWithFrame:CGRectMake(297,0,0.5,0)];
//            
//            _right_view.backgroundColor = RGBCOLOR(237,237,237);
//            
//            [self addSubview:_right_view];
//        }
    }
    
    return self;
}



-(float)setInfomationWith:(FBCircleCommentModel *)model isFirst:(BOOL)isfirst
{
    myModel = model;
    
    float height = isfirst?0:0;
    
    [_headerImageView loadImageFromURL:model.comment_face withPlaceholdImage:PERSONAL_DEFAULTS_IMAGE];
    
    _headerImageView.frame = CGRectMake(_headerImageView.frame.origin.x,_headerImageView.frame.origin.y + height,_headerImageView.frame.size.width,_headerImageView.frame.size.height);
    
    _userName_label.text = model.comment_username;
    
    _userName_label.frame = CGRectMake(_userName_label.frame.origin.x,_userName_label.frame.origin.y + height,_userName_label.frame.size.width,_userName_label.frame.size.height);
    
    _content_label.text = [[ZSNApi FBImageChange:model.comment_content] stringByReplacingEmojiCheatCodesWithUnicode];
    CGSize optimumSize = [_content_label optimumSize];
    
    _content_label.frame = CGRectMake(_content_label.frame.origin.x,31+height,212,optimumSize.height+3);
    
    _dateLine_label.text = [ZSNApi timechange:model.comment_dateline];
    
    
    _upLine_view.frame = CGRectMake(isfirst?0:_upLine_view.frame.origin.x,_upLine_view.frame.origin.y,isfirst?self.frame.size.width:_upLine_view.frame.size.width,isfirst?height:0.5);
    
//    _left_view.frame = CGRectMake(_left_view.frame.origin.x,_left_view.frame.origin.y + height,_left_view.frame.size.width,optimumSize.height + 37 + 10);
//    
//    _right_view.frame = CGRectMake(_right_view.frame.origin.x,_right_view.frame.origin.y + height,_right_view.frame.size.width,optimumSize.height + 37 + 10);
    
    _bottomLine_view.frame = CGRectMake(_bottomLine_view.frame.origin.x,optimumSize.height + 31 + 10 + height - 0.5,_bottomLine_view.frame.size.width,_bottomLine_view.frame.size.height);
    
    return optimumSize.height + 31 + 10 + height;
    
}


-(void)headerTap:(UITapGestureRecognizer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickHeaderWith:)]) {
        [_delegate clickHeaderWith:myModel.comment_uid];
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
