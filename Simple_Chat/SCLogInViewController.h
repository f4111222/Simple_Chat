//
//  SCLogInViewController.h
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/31.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SCInfoViewController.h"
#import "SCRegViewController.h"

@interface SCLogInViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic)  UITextField *User_name;
@property (strong, nonatomic)  UITextField *Password;
@property (strong, nonatomic)  UIButton *Login;
@property (strong, nonatomic)  UIButton *Register;


@end
