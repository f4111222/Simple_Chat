//
//  SCFriendTableView.m
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SCFriendTableView.h"

@implementation SCFriendTableView

@synthesize friends, delegationListener;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self){
        // UITableView properties
        self.backgroundColor = [UIColor clearColor];
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
    return [friends count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"] ;
    }
    cell.textLabel.text = [[friends objectAtIndex:indexPath.row] objectForKey:@"display_name"];
    [cell.imageView sd_setImageWithURL:[[friends objectAtIndex:indexPath.row] objectForKey:@"avatar"] placeholderImage:[UIImage imageNamed:@"avatar.png"]] ;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegationListener BtnClick:[[friends objectAtIndex:indexPath.row] objectForKey:@"user_name"] andNickname:[[friends objectAtIndex:indexPath.row] objectForKey:@"display_name"]];
}

@end
