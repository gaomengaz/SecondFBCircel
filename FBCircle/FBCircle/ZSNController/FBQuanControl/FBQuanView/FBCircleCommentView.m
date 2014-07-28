//
//  FBCircleCommentView.m
//  FBCircle
//
//  Created by soulnear on 14-5-21.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "FBCircleCommentView.h"

@implementation FBCircleCommentView
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(247,247,247);
    }
    return self;
}



-(float)setAllViewsWith:(NSMutableArray *)dataArray
{
    float height = 0;
    
    for (int i = 0;i < dataArray.count;i++)
    {        
        FBCircleCommentModel * model = [dataArray objectAtIndex:i];
        
        NSString * commentString = [NSString stringWithFormat:@"<a href=\"fb://atSomeone@/%@\">%@</a> : %@",model.comment_uid,model.comment_username,model.comment_content];
        
        commentString = [ZSNApi FBImageChange:commentString];
        
        CGRect labelFrame = CGRectMake(0,height,self.frame.size.width,0);
        
        RTLabel * label = [[RTLabel alloc] initWithFrame:CGRectMake(0,height,self.frame.size.width,0)];
                
        label.text = [commentString stringByReplacingEmojiCheatCodesWithUnicode];
        
        label.delegate = self;
        
        label.lineSpacing = 3;
        
        label.textColor = RGBCOLOR(100,100,100);
        
        label.backgroundColor = [UIColor clearColor];
        
        label.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:label];
        
        CGSize optimuSize = [label optimumSize];
                
        labelFrame.size.height = optimuSize.height+4;
        
        label.frame = labelFrame;
        
        height += optimuSize.height + 7;
    }

    return height;
}


-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"点击链接-----%@",[url absoluteString]);
    
    NSString * theUrl = [url absoluteString];
    
    NSString * uid = [theUrl stringByReplacingOccurrencesOfString:@"fb://atSomeone@/" withString:@""];
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickUserNameWithUid:)]) {
        [_delegate clickUserNameWithUid:uid];
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
