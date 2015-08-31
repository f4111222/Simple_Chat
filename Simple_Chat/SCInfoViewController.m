//
//  SCInfoViewController.m
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SCInfoViewController.h"

@interface SCInfoViewController ()

@end

@implementation SCInfoViewController

@synthesize Avatar, NickName, Age, gender, FriendListBtn, UserData, user_name, password;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat view_h = self.view.frame.size.height;
    CGFloat view_w = self.view.frame.size.width;
    
    CGFloat Label_h = view_h/12;
    CGFloat Label_w = view_w/2;
    
    // setting items frame
    Avatar = [[UIImageView alloc] initWithFrame:CGRectMake( view_w/4, view_h/8, view_w/2 , view_w/2)];
    
    CGFloat Avatar_h = Avatar.frame.origin.y + Avatar.frame.size.height;
    
    NickName = [[UILabel alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + Label_h/2 , Label_w, Label_h )];
    [NickName setFont:[UIFont fontWithName:@"Futura" size:20]];
    [NickName setTextColor:[UIColor whiteColor]];
    [NickName setTextAlignment:NSTextAlignmentCenter];
    NickName.backgroundColor = [UIColor grayColor];
    
    Age = [[UILabel alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + 2*Label_h , Label_w, Label_h )];
    [Age setFont:[UIFont fontWithName:@"Futura" size:20]];
    [Age setTextColor:[UIColor whiteColor]];
    [Age setTextAlignment:NSTextAlignmentCenter];
    Age.backgroundColor = [UIColor grayColor];

    gender = [[UILabel alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + 7*Label_h/2 , Label_w, Label_h )];
    [gender setFont:[UIFont fontWithName:@"Futura" size:20]];
    [gender setTextColor:[UIColor whiteColor]];
    [gender setTextAlignment:NSTextAlignmentCenter];
    gender.backgroundColor = [UIColor grayColor];

    FriendListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FriendListBtn.frame = CGRectMake(view_w/4, Avatar_h + 5*Label_h , Label_w, Label_h);
    FriendListBtn.backgroundColor = [UIColor darkGrayColor];
    [FriendListBtn.titleLabel setFont:[UIFont fontWithName:@"Futura" size:20]];
    FriendListBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [FriendListBtn setTitle:@"Friend List" forState:UIControlStateNormal];
    [FriendListBtn addTarget:self action:@selector(GoToFriendList) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Avatar];
    [self.view addSubview:NickName];
    [self.view addSubview:Age];
    [self.view addSubview:gender];
    [self.view addSubview:FriendListBtn];
    [self checkLogin];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) checkLogin{
    
    if (UserData) {
        [Avatar sd_setImageWithURL:[UserData objectForKey:@"avatar"] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
        Age.text =[[UserData objectForKey:@"age"] stringValue];
        NickName.text =[UserData objectForKey:@"display_name"];
        gender.text = [[UserData objectForKey:@"gender"] isEqualToNumber:@1]? @"boy": @"girl";

    }else{
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: user_name
                                    ,@"user_name", password, @"password", nil];

        [manager POST:@"http://104.155.215.148:5566/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            if ([[responseObject objectForKey:@"status"] isEqualToNumber:@1]) {
                //store datas
                UserData =[responseObject objectForKey:@"data"];
                NSString *access_token = [UserData objectForKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
                
                [Avatar sd_setImageWithURL:[UserData objectForKey:@"avatar"] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
                Age.text =[[UserData objectForKey:@"age"] stringValue];
                NickName.text =[UserData objectForKey:@"display_name"];
                gender.text = [[UserData objectForKey:@"gender"] isEqualToNumber:@1]? @"boy": @"girl";
                
            }
            else{
                UIAlertView* errorView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                                    message:[responseObject objectForKey:@"message"]
                                                                   delegate:self   cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
                [errorView show];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
    }
    

}

- (void) GoToFriendList{
    SCFriendViewController *vc = [[SCFriendViewController alloc] init];
    [[self navigationController] pushViewController:vc animated:NO];
}
@end
