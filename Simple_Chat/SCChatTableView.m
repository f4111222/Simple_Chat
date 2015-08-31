//
//  SCChatTableView.m
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/28.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SCChatTableView.h"

@implementation SCChatTableView

@synthesize messages;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self){
        // UITableView properties
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        assert(self.style == UITableViewStylePlain);
        
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


#pragma mark - UITableViewDelegate implementation

#pragma mark - UITableViewDataSource implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"] ;
    }
    cell.textLabel.text = [[messages objectAtIndex:indexPath.row] objectForKey:@"msg"];
    return cell;
}

#pragma mark - Public interface

- (void) scrollBubbleViewToBottomAnimated {
    if ([messages count] > 1) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[messages count]-1 inSection: 0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}


@end
