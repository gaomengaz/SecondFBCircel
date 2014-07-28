//
//  WriteBlogViewController.m
//  FBCircle
//
//  Created by soulnear on 14-5-9.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "WriteBlogViewController.h"
#import "ZSNApi.h"
#import "FriendAttribute.h"


@interface WriteBlogViewController ()
{
    QBImagePickerController * imagePickerController;
}

@end

@implementation WriteBlogViewController
@synthesize delegate = _delegate;
@synthesize myTableView = _myTableView;
@synthesize titleName = _titleName;
@synthesize selectedImageArray = _selectedImageArray;
@synthesize myTextView = _myTextView;
@synthesize isShowLocation = _isShowLocation;
@synthesize locationLabel = _locationLabel;
@synthesize allImageArray = _allImageArray;
@synthesize allAssesters = _allAssesters;
@synthesize TempAllAssesters = _TempAllAssesters;
@synthesize TempAllImageArray = _TempAllImageArray;
@synthesize theType = _theType;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden=NO;
    
}

-(void)back
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"确认取消发送?" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    
    alertView.tag = 417;
    
    [alertView show];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isShowLocation = YES;
    
    self.rightString = @"发送";
    
    
    //
    //    self.leftString = @"取消";
    //
    //    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeText WithRightButtonType:MyViewControllerRightbuttonTypeText];
    
    [ self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeText];
    
    
    self.title = self.theType==WriteBlogWithContent?@"发表说说":@"发表图片";
    
    self.view.backgroundColor = RGBCOLOR(229,229,229);
    
    _allImageArray = [NSMutableArray arrayWithArray:_TempAllImageArray];
    
    _allAssesters = [NSMutableArray arrayWithArray:_TempAllAssesters];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-20-44) style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    self.myTableView.separatorInset = UIEdgeInsetsZero;
    
    self.myTableView.backgroundColor = _theType==WriteBlogWithContent?RGBCOLOR(242,242,242):[UIColor whiteColor];
    
    [self.view addSubview:self.myTableView];
    
    
    UIView * vvvv = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0)];
    
    self.myTableView.tableFooterView = vvvv;
    
    UIView *heitiao=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 6)];
    heitiao.backgroundColor=RGBACOLOR(220, 220, 220, 0.7);
    [self.view addSubview:heitiao];
}

-(void)leftButtonClick:(UIButton *)sender
{
    [self.myTextView resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)doButton:(UIButton *)sender
{
    ChooseCountryViewController * chooseCountry = [[ChooseCountryViewController alloc] init];
    
    [self.navigationController pushViewController:chooseCountry animated:YES];
}



#pragma mark-UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _theType==WriteBlogWithContent?2:3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_theType==WriteBlogWithContent)
    {
        float theHeight = 0;
        
        switch (indexPath.row) {
            case 0:
                theHeight = 80;
                break;
            case 1:
                theHeight = 43;
                break;
                
            default:
                break;
        }
        
        return theHeight;
    }else
    {
        float theHeight = 0;
        
        switch (indexPath.row) {
            case 0:
                theHeight = 80;
                break;
            case 1:
                [self loadChoosePictures];
                theHeight = picturesView.frame.size.height;
                break;
            case 2:
                theHeight = 43;
                break;
                
            default:
                break;
        }
        
        
        return theHeight;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (_theType == WriteBlogWithContent) {
        cell.backgroundColor = RGBCOLOR(251,251,251);
        
        cell.contentView.backgroundColor = RGBCOLOR(251,251,251);
    }
    
    switch (indexPath.row) {
        case 0:
        {
            if (!_myTextView) {
                _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(12,5,296,70)];
                
                _myTextView.font = [UIFont systemFontOfSize:15];
                
                _myTextView.delegate = self;
                
                _myTextView.showsHorizontalScrollIndicator = NO;
                
                _myTextView.showsVerticalScrollIndicator = NO;
                
                _myTextView.returnKeyType = UIReturnKeyDefault;
                
                _myTextView.backgroundColor = [UIColor clearColor];
                
                [cell.contentView addSubview:_myTextView];
                
                
                placeHolderLable = [[UILabel alloc] initWithFrame:CGRectMake(7,7,200,15)];
                
                placeHolderLable.text = @"心情记录...";
                
                placeHolderLable.backgroundColor = [UIColor clearColor];
                
                placeHolderLable.textColor = RGBCOLOR(153,153,153);
                
                placeHolderLable.textAlignment = NSTextAlignmentLeft;
                
                placeHolderLable.font = [UIFont systemFontOfSize:15];
                
                placeHolderLable.userInteractionEnabled = NO;
                
                [_myTextView addSubview:placeHolderLable];
            }
        }
            
            break;
        case 1:
        {
            if (_theType==WriteBlogWithContent) {
                [self loadLoactionViewWithCell:cell];
            }else
            {
                [cell.contentView addSubview:picturesView];
            }
        }
            
            break;
        case 2:
        {
            [self loadLoactionViewWithCell:cell];
        }
            
            break;
            
        default:
            break;
    }
    
    
    return cell;
}


-(void)loadLoactionViewWithCell:(UITableViewCell *)cell
{
    if (!_locationLabel) {
        UIImageView * locaionMarkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingwei-icon-30_36.png"]];
        
        locaionMarkImageView.center = CGPointMake(24,43/2);
        
        locaionMarkImageView.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:locaionMarkImageView];
        
        
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(45,0,200,43)];
        
        _locationLabel.text = @"所在位置";
        
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        
        _locationLabel.textColor = [UIColor blackColor];
        
        _locationLabel.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:_locationLabel];
        
        
        UISwitch * locationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0,0,38,19)];
        
        locationSwitch.center = CGPointMake(280,43/2);
        
        locationSwitch.on = YES;
        
        [locationSwitch addTarget:self action:@selector(ShowLocation:) forControlEvents:UIControlEventValueChanged];
        
        locationSwitch.onImage = [UIImage imageNamed:@"WriteSwitchOutImage.png"];
        
        locationSwitch.offImage = [UIImage imageNamed:@"WriteSwitchBackImage.png"];
        
        [cell.contentView addSubview:locationSwitch];
        
        [self ShowLocation:locationSwitch];
    }
}



#pragma mark-显示地理位置

-(void)ShowLocation:(UISwitch *)sender
{
    isShowLocation = sender.on;
    
    if (sender.on) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    }else
    {
        _locationLabel.text = @"所在位置";
    }
}


-(void)loadLocationDataWith:(CLLocation *)newLocation With:(NSArray *)array
{
    lattitude = newLocation.coordinate.latitude;
    longitude =  newLocation.coordinate.longitude;
    if (array.count > 0)
    {
        CLPlacemark *placemark = [array objectAtIndex:0];
        NSString * country = placemark.administrativeArea;
        //        NSString * city = placemark.subLocality;
        
        _locationLabel.text = country;
        
    }
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    __weak typeof(self) bself = self;
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
     {
         [bself loadLocationDataWith:newLocation With:array];
         
     }];
}



- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    
    NSString *errorString;
    [manager stopUpdatingLocation];
    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
        {
            //Access denied by user
            errorString = @"Access to Location Services denied by user";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务不可用" message:@"建议开启定位服务(设置 -> 隐私 -> 定位服务 -> 开启FBCircle定位服务)" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
            //Do something...
        }
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"Location data unavailable";
            //Do something else...
            break;
        default:
            errorString = @"An unknown error has occurred";
            break;
    }
}



#pragma mark-UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
    {
        [_myTextView resignFirstResponder];
        
        return NO;
    }
    return YES;
}



#pragma mark-UIScrollViewDelegate




#pragma mark-UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        placeHolderLable.text = @"心情记录...";
    }else
    {
        placeHolderLable.text = @"";
    }
}



#pragma mark-QBImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)imagePickerController1:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    NSArray *mediaInfoArray = (NSArray *)info;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    for (int i = 0;i < mediaInfoArray.count;i++)
    {
        UIImage * image = [[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImage * newImage = [SzkAPI scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
        
        [_allImageArray addObject:newImage];
        
        NSURL * url = [[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerReferenceURL"];
        
        NSString * url_string = [[url absoluteString] stringByReplacingOccurrencesOfString:@"/" withString:@""];
        
        url_string = [url_string stringByAppendingString:@".png"];
        
        [_allAssesters addObject:url_string];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            [ZSNApi saveImageToDocWith:url_string WithImage:image];
        });
    }
    
    [self.myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)imagePickerControllerWillFinishPickingMedia:(QBImagePickerController *)imagePickerController
{
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage * newImage = [SzkAPI scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
    
    [_allImageArray addObject:newImage];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error )
     {
         //here is your URL : assetURL
         
         NSString * url_string = [[assetURL absoluteString] stringByReplacingOccurrencesOfString:@"/" withString:@""];
         
         url_string = [url_string stringByAppendingString:@".png"];
         
         [_allAssesters addObject:url_string];
         
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
             [ZSNApi saveImageToDocWith:url_string WithImage:image];
         });
         
     }];
    
    [self.myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
    
}



#pragma mark-多图选择

-(void)loadChoosePictures
{
    
    if (!picturesView) {
        picturesView = [[UIView alloc] init];
    }else
    {
        for (UIView * view in picturesView.subviews)
        {
            if ([view isKindOfClass:[UIButton class]]) {
                [(UIButton *)view setImage:nil forState:UIControlStateNormal];
            }
            
            [view removeFromSuperview];
        }
    }
    
    
    float theHeight = 28;
    
    if (self.allImageArray.count == 0)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(16,14,65,65);
        
        [button setImage:[UIImage imageNamed:@"WriteChoosePictures.png"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(ChooseMorePictures:) forControlEvents:UIControlEventTouchUpInside];
        
        [picturesView addSubview:button];
        
        theHeight += 65;
        
    }else
    {
        
        int count = self.allImageArray.count;
        
        int row = (count%4?1:0) + (count/4);
        
        if (count < 9) {
            row = ((count+1)%4?1:0) + ((count+1)/4);
        }else
        {
            row = 3;
        }
        
        
        for (int i = 0;i < row;i++)
        {
            for (int j = 0;j < 4;j++) {
                
                if (j+4*i < count) {
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame = CGRectMake(16 + 74*j,14 + 74*i,65,65);
                    
                    button.imageView.clipsToBounds = YES;
                    
                    button.tag = 1000+ j + 4*i;
                    
                    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
                    
                    [button setImage:[self.allImageArray objectAtIndex:j+4*i] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(RemoveSelfTap:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [picturesView addSubview:button];
                }else
                {
                    if (j + 4*i == count && count != 9) {
                        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                        
                        button.frame = CGRectMake(16 + 74*j,14 + 74*i,65,65);
                        
                        [button setImage:[UIImage imageNamed:@"WriteChoosePictures.png"] forState:UIControlStateNormal];
                        
                        [button addTarget:self action:@selector(ChooseMorePictures:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [picturesView addSubview:button];
                    }
                }
            }
            
            theHeight += (65 + (i?9:0));
        }
    }
    
    picturesView.frame = CGRectMake(0,0,320,theHeight);
}


-(void)RemoveSelfTap:(UIButton *)sender
{
    WritePreviewDeleteViewController * PreviewDelete = [[WritePreviewDeleteViewController alloc] init];
    
    PreviewDelete.AllImagesArray = self.allImageArray;
    
    PreviewDelete.currentPage = sender.tag-1000;
    
    __weak typeof(self) bself = self;
    
    [PreviewDelete deleteSomeImagesWithBlock:^(int currentPage) {
        
        [bself.allImageArray removeObjectAtIndex:currentPage];
        [bself.allAssesters removeObjectAtIndex:currentPage];
        [bself reloadImagesView];
    }];
    
    [self.navigationController pushViewController:PreviewDelete animated:YES];
}


-(void)reloadImagesView
{
    [self.myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)ChooseMorePictures:(UIButton *)sender
{
    if (self.allAssesters.count == 9)
    {
        myAlertView=[[FBQuanAlertView alloc]initWithFrame:CGRectMake(0,0,140,100)];
        
        myAlertView.center=CGPointMake(160,(iPhone5?568/2:240)-70);
        
        [myAlertView setType:FBQuanAlertViewTypeHaveJuhua thetext:@"最多只能选取9张图片"];
        
        myAlertView.hidden=NO;
        
        [self.view addSubview:myAlertView];
        
        [self performSelector:@selector(dismissAlertView) withObject:nil afterDelay:1];
        
        return;
    }
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    
    [actionSheet showInView:self.view];
}


#pragma mark-自动消失弹出框

-(void)dismissAlertView
{
    [myAlertView removeFromSuperview];
    
    myAlertView = nil;
}


#pragma mark-UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController * pickerC = [[UIImagePickerController alloc] init];
                pickerC.delegate = self;
                pickerC.allowsEditing = NO;
                pickerC.sourceType = sourceType;
                [self presentViewController:pickerC animated:YES completion:nil];
            }
            else
            {
                NSLog(@"模拟其中无法打开照相机,请在真机中使用");
            }
            
        }
            break;
        case 1:
        {
            if (!imagePickerController)
            {
                imagePickerController = nil;
            }
            
            imagePickerController = [[QBImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsMultipleSelection = YES;
            imagePickerController.assters = self.allAssesters;
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
            
            [self presentViewController:navigationController animated:YES completion:NULL];
            
        }
            break;
        case 2:
            NSLog(@"取消");
            break;
            
        default:
            break;
    }
}


#pragma mark-上传相关


//点击发送按钮
-(void)submitData:(UIButton *)sender
{
    NSString * myTextString = [self.myTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (_theType == WriteBlogWithContent && myTextString.length == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        
        [alert show];
        
        return;
    }
    
    FBCircleModel * circleModel = [[FBCircleModel alloc] init];
    
    circleModel.fb_uid = [SzkAPI getUid];
    
    circleModel.fb_username = [SzkAPI getUsername];
    
    circleModel.fb_face = [SzkAPI getUserFace];
    
    circleModel.fb_content = self.myTextView.text;
    
    circleModel.fb_deteline = [ZSNApi timechangeToDateline];
    
    circleModel.fb_image = self.allImageArray;
    
    NSLog(@"allimagearray ----   %@",circleModel.fb_imageid);
    
    circleModel.fb_imageid = [self returnAllImageUrlWithImage:self.allImageArray];
    
    circleModel.fb_area = area_string;
    
    circleModel.fb_lng = [NSString stringWithFormat:@"%f",longitude];
    
    circleModel.fb_lat = [NSString stringWithFormat:@"%f",lattitude];
    
    circleModel.fb_authkey = [SzkAPI getAuthkey];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(upLoadBlogWith:)])
    {
        [_delegate upLoadBlogWith:circleModel];
    }
    
        
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appdelegate.uploadData uploadBlogWith:circleModel];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    return;
    
    
    myAlertView=[[FBQuanAlertView alloc]initWithFrame:CGRectMake(0,0,140,100)];
    
    myAlertView.center=CGPointMake(160,(iPhone5?568/2:240)-70);
    
    [myAlertView setType:FBQuanAlertViewTypeHaveJuhua thetext:@"正在发送....."];
    
    myAlertView.hidden=NO;
    
    [self.view addSubview:myAlertView];
    
    
    
    [_myTextView resignFirstResponder];
    
    //点击发送按钮 发送文章时的弹窗提示
    
//    _alerSending = [[UIAlertView alloc]initWithTitle:@"正在努力为您发送" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    [_alerSending show];
    
    
    
    
    if (self.allImageArray.count) {
        [self zkingupdataImages];
    }else
    {
        NSString * fullUrl = @"";
        
        if (isShowLocation && ![_locationLabel.text isEqualToString:@"所在位置"]) {
            fullUrl = [NSString stringWithFormat:PUBLISH_TEXT_LOCATION,[[NSUserDefaults standardUserDefaults] objectForKey:@"autherkey"],[_myTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],longitude,lattitude,[_locationLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }else
        {
            fullUrl = [NSString stringWithFormat:PUBLISH_TEXT,[[NSUserDefaults standardUserDefaults] objectForKey:@"autherkey"],[_myTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
        }
        
        [self sendBlogWithUrl:fullUrl];
    }
    
}



-(void)uploadImages
{
    __weak typeof(self) bself = self;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    AFHTTPRequestOperation  * o2= [manager
    //                                   POST:[NSString stringWithFormat:PUBLISH_IMAGE,[[NSUserDefaults standardUserDefaults]objectForKey:AUTHERKEY]]
    //                                   parameters:nil
    //                                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    //                                   {
    //                                       //开始拼接表单
    //                                       //获取图片的二进制形式
    //
    //
    //                                       for (int i = 0;i < bself.allImageArray.count;i++) {
    //                                           UIImage * image = [bself.allImageArray objectAtIndex:0];
    //
    //                                           UIImage * newImage = [ZSNApi scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
    //
    //                                           NSData * data= UIImagePNGRepresentation(image);
    //
    //                                           data = UIImageJPEGRepresentation(newImage,0.5);
    //
    //                                           //将得到的二进制图片拼接到表单中
    //                                           /**
    //                                            *  data,指定上传的二进制流
    //                                            *  name,服务器端所需参数名
    //                                            *  fileName,指定文件名
    //                                            *  mimeType,指定文件格式
    //                                            */
    //                                           [formData appendPartWithFileData:data name:@"quan_img[]" fileName:@"quan_img.png" mimeType:@"image/png"];
    //                                       }
    //
    //
    //                                       //多用途互联网邮件扩展（MIME，Multipurpose Internet Mail Extensions）
    //                                   }
    //                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
    //                                   {
    //                                       NSDictionary * allDic = [operation.responseString objectFromJSONString];
    //
    //                                       NSLog(@"-----%@",[[operation.responseString objectFromJSONString] objectForKey:@"errinfo"]);
    //
    //                                       NSLog(@"datainfo-----%@",[[operation.responseString objectFromJSONString] objectForKey:@"datainfo"]);
    //
    //
    //                                       if ([[allDic objectForKey:@"errcode"] intValue] == 0) {
    //
    //                                           [bself sendBlogWithArray:[allDic objectForKey:@"datainfo"]];
    //
    //
    //                                       }else
    //                                       {
    //                                           [bself sendErrorWith:[allDic objectForKey:@"datainfo"]];
    //                                       }
    //                                   }
    //                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //                                       [bself sendErrorWith:@"请检查当前网络状态"];
    //                                   }];
    
    AFHTTPRequestOperation  * o2= [manager
                                   POST:[NSString stringWithFormat:@""]
                                   parameters:nil
                                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                   {
                                       //开始拼接表单
                                       //获取图片的二进制形式
                                       
                                       
                                       for (int i = 0;i < bself.allImageArray.count;i++) {
                                           UIImage * image = [bself.allImageArray objectAtIndex:0];
                                           
                                           UIImage * newImage = [ZSNApi scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
                                           
                                           NSData * data= UIImagePNGRepresentation(image);
                                           
                                           data = UIImageJPEGRepresentation(newImage,0.5);
                                           
                                           //将得到的二进制图片拼接到表单中
                                           /**
                                            *  data,指定上传的二进制流
                                            *  name,服务器端所需参数名
                                            *  fileName,指定文件名
                                            *  mimeType,指定文件格式
                                            */
                                           [formData appendPartWithFileData:data name:@"quan_img[]" fileName:@"quan_img.png" mimeType:@"image/png"];
                                       }
                                       
                                       
                                       //多用途互联网邮件扩展（MIME，Multipurpose Internet Mail Extensions）
                                   }
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
                                   {
                                       NSDictionary * allDic = [operation.responseString objectFromJSONString];
                                       
                                       NSLog(@"-----%@",[[operation.responseString objectFromJSONString] objectForKey:@"errinfo"]);
                                       
                                       NSLog(@"datainfo-----%@",[[operation.responseString objectFromJSONString] objectForKey:@"datainfo"]);
                                       
                                       
                                       if ([[allDic objectForKey:@"errcode"] intValue] == 0) {
                                           
                                           [bself sendBlogWithArray:[allDic objectForKey:@"datainfo"]];
                                           
                                           
                                       }else
                                       {
                                           [bself sendErrorWith:[allDic objectForKey:@"datainfo"]];
                                       }
                                   }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       
                                       [bself sendErrorWith:@"请检查当前网络状态"];
                                   }];
    
    
    
}
#pragma mark--请求图片
//上传图片
#define TT_CACHE_EXPIRATION_AGE_NEVER     (1.0 / 0.0)   // inf
- (void)zkingupdataImages
{
    
    NSString* fullURL = [NSString stringWithFormat:PUBLISH_IMAGE,[[NSUserDefaults standardUserDefaults]objectForKey:AUTHERKEY]];
    //  NSString * fullURL = [NSString stringWithFormat:@"http://t.fblife.com/openapi/index.php?mod=doweibo&code=addpicmuliti&fromtype=b5eeec0b&authkey=UmZaPlcyXj8AMQRoDHcDvQehBcBYxgfbtype=json"];
    
    
    NSLog(@"上传图片的url  ——--  %@",fullURL);
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:fullURL]];
    request.delegate = self;
    request.tag = 1;
    
    //得到图片的data
    NSData* data;
    //获取图片质量
    //  NSString *tupianzhiliang=[[NSUserDefaults standardUserDefaults] objectForKey:TUPIANZHILIANG];
    
    NSMutableData *myRequestData=[NSMutableData data];
    
    NSLog(@"imagearray -----  %d",_allImageArray.count);
    
    for (int i = 0;i < _allImageArray.count; i++)
    {
        [request setPostFormat:ASIMultipartFormDataPostFormat];
        
        UIImage *image=[_allImageArray objectAtIndex:i];
        
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedImage%d.png",i]];
        //also be .jpg or another
        NSData *imageData = UIImagePNGRepresentation(image);
        //UIImageJPEGRepresentation(image)
        [imageData writeToFile:savedImagePath atomically:NO];
        
    
        
//        UIImage * newImage = [SzkAPI scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
        
        data = UIImageJPEGRepresentation(image,0.5);
        
        
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [myRequestData length]]];
        
        //设置http body
        
        [request addData:data withFileName:[NSString stringWithFormat:@"quan_img[%d].png",i] andContentType:@"image/PNG" forKey:@"quan_img[]"];
        
        //  [request addData:myRequestData forKey:[NSString stringWithFormat:@"boris%d",i]];
        
    }
    
    [request setRequestMethod:@"POST"];
    
    request.cachePolicy = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    request.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
    
    [request startAsynchronous];
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"发送失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertV show];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    
    
    __weak typeof(self) bself=self;
    
    NSDictionary * allDic = [request.responseString objectFromJSONString];
    
    NSLog(@"-----%@",[[request.responseString objectFromJSONString] objectForKey:@"errinfo"]);
    
    NSLog(@"datainfo-----%@",[[request.responseString objectFromJSONString] objectForKey:@"datainfo"]);
    
    
    if ([[allDic objectForKey:@"errcode"] intValue] == 0) {
        
        
        [bself sendBlogWithArray:[allDic objectForKey:@"datainfo"]];
        
        
    }else
    {
        //[bself sendErrorWith:[allDic objectForKey:@"datainfo"]];
    }
    
    
}

-(void)sendBlogWithArray:(NSArray *)array
{
    
    NSString* authod = @"ssss";
    
    for (int i = 0;i < array.count;i++)
    {
        if (i == 0)
        {
            authod = [[array objectAtIndex:i] objectForKey:@"imageid"];
        }else
        {
            authod = [NSString stringWithFormat:@"%@,%@",authod,[[array objectAtIndex:i] objectForKey:@"imageid"]];
        }
    }
    
    NSLog(@"图片id -----   %@",authod);
    
    NSString * fullUrl = @"";
    if (isShowLocation && ![_locationLabel.text isEqualToString:@"所在位置"]) {
        
        
        NSLog(@"xxx===%@",_myTextView.text);
        fullUrl = [NSString stringWithFormat:PUBLISH_IMAGE_TEXT_LOCATION,[[NSUserDefaults standardUserDefaults]objectForKey:AUTHERKEY],[self.myTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                   ,authod,longitude,lattitude,[_locationLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"fullurl==%@",fullUrl);
        
        
        
    }else
    {
        fullUrl = [NSString stringWithFormat:PUBLISH_IMAGE_TEXT,[[NSUserDefaults standardUserDefaults] objectForKey:AUTHERKEY],[_myTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[authod stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding]];
    }
    
    
    [self sendBlogWithUrl:fullUrl];
}



-(void)sendBlogWithUrl:(NSString *)urlString
{
    
    SzkLoadData *_loaddata=[[SzkLoadData alloc]init];
    [_loaddata SeturlStr:urlString block:^(NSArray *arrayinfo, NSString *errorindo, int errcode) {
        if (errcode==0)
        {
            //        if ([[allDic objectForKey:@"errcode"] intValue] == 0) {
            NSLog(@"发表成功");
            
            //移除发送中alert提示框
//            [_alerSending dismissWithClickedButtonIndex:0 animated:0];
            
            [myAlertView removeFromSuperview];
            
            myAlertView = nil;
            
            [[NSNotificationCenter defaultCenter]postNotificationName:SUCCESSUPDATA object:nil];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            
        }else{
            
//            [_alerSending dismissWithClickedButtonIndex:0 animated:0];
            
            [myAlertView removeFromSuperview];
            
            myAlertView = nil;
            
            NSLog(@"xxx==code==%d==%@",errcode,errorindo);
            
            UIAlertView * alertView = [[UIAlertView alloc]  initWithTitle:@"提示" message:errorindo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            
            [alertView show];
            
        }
    }];
    
    //    NSLog(@"发表微博url-----%@",urlString);
    //
    //    AFHTTPRequestOperation * Operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    //
    //    __block AFHTTPRequestOperation * request = Operation;
    //
    //
    //
    //    [request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //        NSDictionary * allDic = [Operation.responseString objectFromJSONString];
    //
    //        NSLog(@"allDic-------%@",allDic);
    //
    //        if ([[allDic objectForKey:@"errcode"] intValue] == 0) {
    //            NSLog(@"发表成功");
    //
    //            //移除发送中alert提示框
    //            [_alerSending dismissWithClickedButtonIndex:0 animated:0];
    //
    //            [[NSNotificationCenter defaultCenter]postNotificationName:SUCCESSUPDATA object:nil];
    //            [self dismissViewControllerAnimated:YES completion:^{
    //
    //            }];
    //        }
    //
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"失败了吗------%@-------%@",Operation.responseString,error);
    //
    //        //移除发送中alert提示框
    //        [_alerSending dismissWithClickedButtonIndex:0 animated:0];
    //
    //        //提示发送失败
    //        [self sendErrorWith:@"请检查网络"];
    //
    //    }];
    //
    //
    //    [Operation start];
}

//发送失败的提示框
-(void)sendErrorWith:(NSString *)error
{
    [myAlertView removeFromSuperview];
    
    myAlertView = nil;
    
    if (!_alertSendError) {
        _alertSendError = [[UIAlertView alloc] initWithTitle:@"发布失败" message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        _alertSendError.tag = 256;
        
        [_alertSendError show];
    }
    
}



#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 256) {
        if (buttonIndex == 0) {
            _alertSendError = nil;
        }
    }else if (alertView.tag == 417)
    {
        switch (buttonIndex) {
            case 0:
                
                break;
            case 1:
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                break;
                
            default:
                break;
        }
    }
    
}



#pragma mark-返回所有图片url

-(NSString *)returnAllImageUrlWithImage:(NSMutableArray *)allimage
{
    NSString * allImageUrl = @"";
    
    for (int i = 0;i < self.allAssesters.count;i++)
    {
        NSString * string = [self.allAssesters objectAtIndex:i];
        
        if (i == 0)
        {
            allImageUrl = [NSString stringWithFormat:@"%@",string];
        }else
        {
            allImageUrl = [NSString stringWithFormat:@"%@||%@",allImageUrl,string];
        }
        
//        UIImage * image = [allimage objectAtIndex:i];
        
//        [ZSNApi saveImageToDocWith:string WithImage:image];
    }
    
    NSLog(@"allimageurl ------   %@",allImageUrl);
    
    return allImageUrl;
}



-(void)dealloc
{
    for (UIView * view in picturesView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setImage:nil forState:UIControlStateNormal];
        }
        
        [view removeFromSuperview];
    }
    
    [_allImageArray removeAllObjects];
    
    [_allAssesters removeAllObjects];
    
    [_TempAllAssesters removeAllObjects];
    
    [_TempAllImageArray removeAllObjects];
    
    [_selectedImageArray removeAllObjects];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
