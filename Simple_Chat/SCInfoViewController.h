//
//  SCInfoViewController.h
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SCFriendViewController.h"
#import "AFNetworking.h"

@interface SCInfoViewController : UIViewController

@property (strong, nonatomic)  NSDictionary *UserData;
@property (strong, nonatomic)  NSString *user_name;
@property (strong, nonatomic)  NSString *password;
@property (strong, nonatomic)  UIImageView *Avatar;
@property (strong, nonatomic)  UILabel *NickName;
@property (strong, nonatomic)  UILabel *Age;
@property (strong, nonatomic)  UILabel *gender;
@property (strong, nonatomic)  UIButton *FriendListBtn;

@end
