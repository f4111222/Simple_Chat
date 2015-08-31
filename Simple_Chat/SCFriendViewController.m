//
//  SCFriendViewController.m
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SCFriendViewController.h"

@interface SCFriendViewController ()

@end

@implementation SCFriendViewController

@synthesize Table;

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"Friend";
    self.view.backgroundColor = [UIColor whiteColor];
    Table = [[SCFriendTableView alloc] initWithFrame:self.view.frame];
    Table.delegationListener = self;
    [self.view addSubview:Table];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:token,@"access_token",nil];

    [manager GET:@"http://104.155.215.148:5566/users" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([[responseObject objectForKey:@"status"] isEqualToNumber:@1]) {
            //store datas
            Table.friends =[responseObject objectForKey:@"data"];
            [Table reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SCFriendTableelegate

-(void) BtnClick:(NSString *)user_name andNickname:(NSString *)nickname{
    SCChatViewController *vc = [[SCChatViewController alloc] init];
    vc.userName = user_name;
    vc.nickname = nickname;
    [[self navigationController] pushViewController:vc animated:NO];
}

@end
