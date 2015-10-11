//
//  NewItemViewController2.m
//  L-FMS-iOS
//
//  Created by 虎猫儿 on 15/10/10.
//  Copyright (c) 2015年 虎猫儿. All rights reserved.
//

#import "NewItemViewController2.h"
#import "LFChooseLocationMapViewController.h"

#import "LFCommon.h"
#import "LFImageView.h"

#import <CoreLocation/CoreLocation.h>
#import "LFBaiduMapKit.h"

#define kNewItemVC22ChooseLocationMapVCSegueId @"NewItemVC22ChooseLocationMapVCSegueId"

@interface NewItemViewController2 ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,LFChooseLocationMapViewControllerDelegate,BMKGeoCodeSearchDelegate> {
    BOOL _isLost ;
    NSString *_locationString ;
    CLLocationCoordinate2D _choosedCoordinate2D ;
}

@property (weak, nonatomic) IBOutlet UITextView *textView ;
@property (weak, nonatomic) IBOutlet LFImageView *imageView ;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView ;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel ;

@end

@implementation NewItemViewController2

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
    [self.imageView set2PlaceHolderImage] ;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked)] ;
    [self.imageView addGestureRecognizer:tapGes] ;
    self.imageView.userInteractionEnabled = YES ;
    
    self.iconImageView.userInteractionEnabled = YES ;
    tapGes = [[UITapGestureRecognizer alloc] init] ;
    [tapGes addTarget:self action:@selector(iconClicked)] ;
    [self.iconImageView addGestureRecognizer:tapGes] ;
    _isLost = YES ;
    
    
    _locationString = nil ;
    self.locationLabel.userInteractionEnabled = YES ;
    tapGes = [[UITapGestureRecognizer alloc] init] ;
    [tapGes addTarget:self action:@selector(locationClicked)] ;
    [self.locationLabel addGestureRecognizer:tapGes] ;
    
    self.textView.text = @"" ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning] ;
    
}

#pragma mark - IBActions 

- (UIActionSheet *)getAImagePickerActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选取照片"
                                                             delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil] ;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque ;
    
    return actionSheet ;
}

- (void)imageClicked {
    QYDebugLog(@"233") ;
    UIActionSheet *actionSheet = [self getAImagePickerActionSheet] ;
    [actionSheet showInView:self.view] ;
}

- (void)iconClicked {
    _isLost = _isLost ^ TRUE ;
    if ( _isLost )
        self.iconImageView.image = [UIImage imageNamed:@"Lost"] ;
    else
        self.iconImageView.image = [UIImage imageNamed:@"Found"] ;
}

- (void)locationClicked {
    [self performSegueWithIdentifier:kNewItemVC22ChooseLocationMapVCSegueId sender:self] ;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch ( buttonIndex ) {
        case 0 : {
            //拍照
            QYDebugLog(@"拍照") ;
            [LFUtils pickImageFromCameraAtController:self] ;
            break ;
        }
            
        case 1 : {
            QYDebugLog(@"从相册选择") ;
            [LFUtils pickImageFromPhotoLibraryAtController:self] ;
            break ;
        }
            
        case 2 : {
            
            break ;
        }
            
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image] ;
        }) ;
    });
    
    [picker dismissViewControllerAnimated:YES completion:nil] ;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    QYDebugLog(@"取消") ;
    [picker dismissViewControllerAnimated:YES completion:nil] ;
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder] ;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [segue.identifier isEqualToString:kNewItemVC22ChooseLocationMapVCSegueId]) {
        LFChooseLocationMapViewController *vc = segue.destinationViewController ;
        vc.delegate = self ;
    }
}

#pragma mark - LFChooseLocationMapViewControllerDelegate

- (void)viewController:(LFChooseLocationMapViewController *)vc didClickedLocation:(CLLocation *)location {
    //
    BMKGeoCodeSearch *search = [[BMKGeoCodeSearch alloc] init] ;
    search.delegate = self ;
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init] ;
    option.reverseGeoPoint = location.coordinate ;
    
    BOOL flag = [search reverseGeoCode:option] ;
    
    if ( flag ) {
        QYDebugLog(@"请求成功") ;
    } else {
        QYDebugLog(@"请求失败") ;
    }
    
}

#pragma mark - BMKGeoCodeSearchDelegate

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if ( error == BMK_SEARCH_NO_ERROR ) {
        self.locationLabel.text = result.address ;
    }
}

@end