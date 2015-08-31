//
//  SCChatViewController.h
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/28.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCChatTableView.h"
#import "AFNetworking.h"

@interface SCChatViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>{
    NSMutableArray *chat;
}

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic,strong) SCChatTableView *Table;
@property (nonatomic,strong) UIView *textView;
@property (nonatomic,strong) UITextField *TypeWord;
@property (nonatomic,strong) UIButton *Send;

@end
