//
//  NewFaceView.m
//  越野e族
//
//  Created by soulnear on 13-12-27.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "NewFaceView.h"

@implementation NewFaceView
@synthesize deletage = _deletage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)createExpressionWithPage:(int)page
{
    page = self.tag - 100;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 6; j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i*6+j+page*28+1;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(17+51.6*j,16.75+42*i,28,28);
            
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Expression_%d",i*6 + j + page*28+1]] forState:UIControlStateNormal];
            if (button.imageView.image == nil)
            {
                [button setEnabled:NO];
            }
            [self addSubview:button];
        }
    }
}

-(void)buttonClick:(UIButton *)button
{
    
    NSLog(@"button.tag === %d",button.tag);
    NSString *name;
    if (button.tag==1) name =@"[愣神]";
    else if  (button.tag==2)name =@"[思考]";
    else if  (button.tag==3)name =@"[大笑]";
    else if  (button.tag==4)name =@"[大哭]";
    else if  (button.tag==5)name =@"[发怒]";
    else if  (button.tag==6)name =@"[恶魔]";
    else if  (button.tag==7)name =@"[撇嘴]";
    else if  (button.tag==8)name =@"[害羞]";
    else if  (button.tag==9)name =@"[霸气]";
    else if  (button.tag==10)name =@"[睡觉]";
    else if  (button.tag==11)name =@"[真棒]";
    else if  (button.tag==12)name =@"[晕菜]";
    else if  (button.tag==13)name =@"[礼物]";
    else if  (button.tag==14)name =@"[微笑]";
    else if  (button.tag==15)name =@"[鬼脸]";
    else if  (button.tag==16)name =@"[傻笑]";
    else if  (button.tag==17)name =@"[可爱]";
    else if  (button.tag==18)name =@"[憨笑]";
    else if  (button.tag==19)name =@"[伤心]";
    else if  (button.tag==20)name =@"[惊讶]";
    else if  (button.tag==21)name =@"[哈欠]";
    else if  (button.tag==22)name =@"[劈掌]";
    else if  (button.tag==23)name =@"[得意]";
    else if  (button.tag==24)name =@"[大爱]";
    else if  (button.tag==25)name =@"[大笑]";
    else if  (button.tag==26)name =@"[吐]";
    else if  (button.tag==27)name =@"[尴尬]";
    else if  (button.tag==28)name =@"[感动]";
    else if  (button.tag==29)name =@"[纠结]";
    else if  (button.tag==30)name =@"[宠物]";
    else if  (button.tag==31)name =@"[睡觉]";
    else if  (button.tag==32)name =@"[奋斗]";
    else if  (button.tag==33)name =@"[左哼]";
    else if  (button.tag==34)name =@"[右哼]";
    else if  (button.tag==35)name =@"[崩溃]";
    else if  (button.tag==36)name =@"[委屈]";
    else if  (button.tag==37)name =@"[疑问]";
    else if  (button.tag==38)name =@"[太棒了]";
    else if  (button.tag==39)name =@"[鄙视]";
    else if  (button.tag==40)name =@"[打哈欠]";
    else if  (button.tag==41)name =@"[无语]";
    else if  (button.tag==42)name =@"[亲亲]";
    else if  (button.tag==43)name =@"[恐惧]";
    else if  (button.tag==44)name =@"[骷髅]";
    else if  (button.tag==45)name =@"[俏皮]";
    else if  (button.tag==46)name =@"[爱财]";
    else if  (button.tag==47)name =@"[海盗]";
    else if  (button.tag==48)name =@"[难受]";
    else if  (button.tag==49)name =@"[思考]";
    else if  (button.tag==50)name =@"[感冒]";
    else if  (button.tag==51)name =@"[闭嘴]";
    else if  (button.tag==52)name =@"[菜刀]";
    else if  (button.tag==53)name =@"[礼物]";
    else if  (button.tag==54)name =@"[药水]";
    else if  (button.tag==55)name =@"[雨天]";
    else if  (button.tag==56)name =@"[砸]";
    else if  (button.tag==57)name =@"[炸弹]";
    else if  (button.tag==58)name =@"[胜利]";
    else if  (button.tag==59)name =@"[发飙]";
    else if  (button.tag==60)name =@"[喜欢]";
    else if  (button.tag==61)name =@"[不错]";
    else if  (button.tag==62)name =@"[大爱]";
    else if  (button.tag==63)name =@"[仰慕]";
    else name =@"[微笑]";
    
    
    
    
    if (self.deletage)
    {
        [self.deletage expressionClickWith:self faceName:name];
    }
}

@end
