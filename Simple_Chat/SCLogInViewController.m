//
//  SCLogInViewController.m
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/31.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SCLogInViewController.h"

@interface SCLogInViewController ()

@end

@implementation SCLogInViewController

@synthesize User_name, Password, Login, Register;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat view_h = self.view.frame.size.height;
    CGFloat view_w = self.view.frame.size.width;
    
    CGFloat Label_h = view_h/10;
    CGFloat Label_w = view_w/2;
    
    // setting items frame
    User_name = [[UITextField alloc] initWithFrame:CGRectMake(view_w/4, view_h/5 , Label_w, Label_h )];
    User_name.delegate =self;
    [User_name setFont:[UIFont fontWithName:@"Futura" size:20]];
    User_name.placeholder = @"User_Name";
    [User_name setTextColor:[UIColor whiteColor]];
    [User_name setTextAlignment:NSTextAlignmentCenter];
    User_name.backgroundColor = [UIColor grayColor];
    
    Password = [[UITextField alloc] initWithFrame:CGRectMake(view_w/4, 2*view_h/5 , Label_w, Label_h )];
    Password.delegate = self;
    [Password setFont:[UIFont fontWithName:@"Futura" size:20]];
    Password.placeholder = @"Password";
    [Password setTextColor:[UIColor whiteColor]];
    [Password setTextAlignment:NSTextAlignmentCenter];
    Password.backgroundColor = [UIColor grayColor];
    
    Login = [UIButton buttonWithType:UIButtonTypeCustom];
    Login.frame = CGRectMake(view_w/4, 3*view_h/5 , Label_w, Label_h);
    Login.backgroundColor = [UIColor darkGrayColor];
    [Login.titleLabel setFont:[UIFont fontWithName:@"Futura" size:20]];
    Login.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Login setTitle:@"Login" forState:UIControlStateNormal];
    [Login addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    
    Register = [UIButton buttonWithType:UIButtonTypeCustom];
    Register.frame = CGRectMake(view_w/4, 4*view_h/5 , Label_w, Label_h);
    Register.backgroundColor = [UIColor darkGrayColor];
    [Register.titleLabel setFont:[UIFont fontWithName:@"Futura" size:20]];
    Register.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Register setTitle:@"Register" forState:UIControlStateNormal];
    [Register addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:User_name];
    [self.view addSubview:Password];
    [self.view addSubview:Login];
    [self.view addSubview:Register];
    
    //when click outside, hide the keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnKB:)];
    [self.view addGestureRecognizer:tap];

}

- (void)returnKB:(id)sender {
    [User_name resignFirstResponder];
    [Password resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Login

-(void) Login:(id) sender{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:User_name.text,@"user_name", Password.text, @"password", nil];
    
    [manager POST:@"http://104.155.215.148:5566/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] isEqualToNumber:@1]) {
            //store datas
            NSString *access_token = [[responseObject objectForKey:@"data"] objectForKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
            
            SCInfoViewController *vc = [[SCInfoViewController alloc] init];
            vc.UserData =[responseObject objectForKey:@"data"];
            [[self navigationController] pushViewController:vc animated:NO];
            
        }
        else{
            UIAlertView* errorView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                                message:[responseObject objectForKey:@"error"]
                                                               delegate:self   cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
            [errorView show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Register

-(void) Register:(id)sender{
    SCRegViewController *vc = [[SCRegViewController alloc] init];
    [[self navigationController] pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
