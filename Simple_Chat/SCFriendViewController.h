//
//  SCFriendViewController.h
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCFriendTableView.h"
#import "SCChatViewController.h"
#import "AFNetworking.h"

@interface SCFriendViewController : UIViewController<SCFriendTableelegate, UINavigationBarDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) SCFriendTableView *Table;

@end
