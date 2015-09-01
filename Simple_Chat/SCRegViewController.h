//
//  SCRegViewController.h
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SCInfoViewController.h"
#import "VPImageCropperViewController.h"


@interface SCRegViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, VPImageCropperDelegate, UINavigationControllerDelegate>{
    NSArray *genderArray;
    UIPickerView *genderView;
}

@property (strong, nonatomic)  NSString *imgURL;
@property (strong, nonatomic)  UIImageView *Avatar;
@property (strong, nonatomic)  UIButton *Avatarbtn;
@property (strong, nonatomic)  UITextField *User_name;
@property (strong, nonatomic)  UITextField *Password;
@property (strong, nonatomic)  UITextField *NickName;
@property (strong, nonatomic)  UITextField *Age;
@property (strong, nonatomic)  UITextField *Gender;
@property (strong, nonatomic)  UIButton *Register;

@end
