//
//  FriendListCell.m
//  FBCircle
//
//  Created by 史忠坤 on 14-5-13.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "FriendListCell.h"

@implementation FriendListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _headImageV=[[UIImageView alloc]init];
        
        CALayer *l = [_headImageV layer];   //获取ImageView的层
        [l setMasksToBounds:YES];
        [l setCornerRadius:3.0f];
        
       // _headImageV.backgroundColor=[UIColor redColor];
        [self addSubview:_headImageV];
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.textColor=[UIColor blackColor];
        [self addSubview:_nameLabel];
        
//        _nameLabel.userInteractionEnabled=YES;
//        self.userInteractionEnabled=YES;
        
//        /*instantiate the object */
//        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(qingright)];
//        /*Swipes that are performed from right to left are to be detected*/
//        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//        /*just one finger needed*/
//        swipeGestureRecognizer.numberOfTouchesRequired = 1;
//        /*add it to the view*/
//        [_nameLabel addGestureRecognizer:swipeGestureRecognizer];
    }
    return self;
}
/**
 */
-(void)setFriendAttribute:(FriendAttribute *)FriendAttributemodel{
    
    /**
     *          face = "http://bbs.fblife.com/ucenter/avatar.php?uid=355696&type=virtual&size=small";
     status = 1;
     uid = 355696;
     uname = ivyandrich;
     */
    
    
    [_headImageV setImageWithURL:[NSURL URLWithString:FriendAttributemodel.face] placeholderImage:[UIImage imageNamed:@"xiaotouxiang_92_92.png"]];
    _nameLabel.text=FriendAttributemodel.uname;

}

-(void)layoutSubviews{
    
    _headImageV.frame=CGRectMake(12, 12, 46, 46);

    _nameLabel.frame=CGRectMake(75, 0, 150, self.frame.size.height);

}

- (void)qingright
{
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:2];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_nameLabel cache:YES];
//    [UIView commitAnimations];
    
    NSLog(@"q");
    
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//  
//    NSLog(@"1111111111");
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
