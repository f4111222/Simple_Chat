//
//  SCChatTableView.h
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/28.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCChatTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *messages;

- (void) scrollBubbleViewToBottomAnimated;

@end
