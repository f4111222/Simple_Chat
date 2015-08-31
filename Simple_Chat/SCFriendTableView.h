//
//  SCFriendTableView.h
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@class SCFriendTableView;

@protocol SCFriendTableelegate <NSObject>
-(void)BtnClick:(NSString *)user_name andNickname:(NSString *)nickname;
@end

@interface SCFriendTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic,assign) id<SCFriendTableelegate> delegationListener;

@end
