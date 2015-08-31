//
//  SCChatViewController.m
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/28.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SCChatViewController.h"

@interface SCChatViewController ()

@end

@implementation SCChatViewController

@synthesize Table, Send, TypeWord, textView, userName, nickname;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //set TextView frame
    CGFloat textView_x = 0;
    CGFloat textView_y = self.view.frame.size.height - self.view.frame.size.height/10;
    CGFloat textView_w = self.view.frame.size.width;
    CGFloat textView_h = self.view.frame.size.height/10;
    
    textView = [[UIView alloc] initWithFrame:CGRectMake(textView_x, textView_y, textView_w, textView_h)];
    [textView setBackgroundColor:[UIColor darkGrayColor]];
    textView.alpha = 0.9;

    //set Table view frame
    CGFloat table_x = 0;
    CGFloat table_y = 0;
    CGFloat table_w = self.view.frame.size.width;
    CGFloat table_h = self.view.frame.size.height - textView_h ;
    Table = [[SCChatTableView alloc] initWithFrame:CGRectMake(table_x, table_y, table_w, table_h)];
    [self.view addSubview:Table];
    
    //set TextField frame & keyboard
    TypeWord = [[UITextField alloc] initWithFrame:CGRectMake(textView_w/20, textView_h/10, textView_w*2 /3,textView_h*4/5 )];
    TypeWord.borderStyle = UITextBorderStyleRoundedRect;
    TypeWord.keyboardType = UIKeyboardTypeDefault;
    TypeWord.keyboardAppearance = UIKeyboardAppearanceLight;
    [textView addSubview:TypeWord];
    TypeWord.delegate = self;

    //set Send Btn frame
    Send = [UIButton buttonWithType:UIButtonTypeCustom];
    Send = [[UIButton alloc] initWithFrame:CGRectMake( textView_w*4/5, textView_h/10 , textView_h*4/5 , textView_h*4/5)];
    [Send setImage:[UIImage imageNamed:@"chat-send.png"] forState:UIControlStateNormal];
    [Send addTarget:self action:@selector(SendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:Send];
    [self.view addSubview:textView];
    
    // get msg
    [self GetMessage];
    
    //adjust the View for keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardisShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardisShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardisHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    //when click outside, hide the keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnKB:)];
    [self.view addGestureRecognizer:tap];

}

-(void) viewWillAppear:(BOOL)animated{
    self.navigationItem.title = nickname;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) GetMessage{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:token,@"access_token",userName,@"user_name",nil];
    
    [manager GET:@"http://104.155.215.148:5566/msgs" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([[responseObject objectForKey:@"status"] isEqualToNumber:@1]) {
            //store datas
            chat = [[NSMutableArray alloc] init];
            for (int i = [[responseObject objectForKey:@"data"] count]-1; i>=0; i--) {
                [chat addObject:[[responseObject objectForKey:@"data"] objectAtIndex:i] ];
            }
            Table.messages =chat;
            [Table reloadData];
            [Table scrollBubbleViewToBottomAnimated];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void) SendMessage:(id) sender{
    
    //send and wait to check whether success
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:token,@"access_token", userName,@"user_name",TypeWord.text, @"msg",nil];
    
    [manager POST:@"http://104.155.215.148:5566/msgs" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] isEqualToNumber:@1]) {
            //send message success  - show new message
            [chat addObject:[responseObject objectForKey:@"data"]];
            Table.messages = chat;
            [Table reloadData];
            
            //Scroll Table view to bottom
            [Table scrollBubbleViewToBottomAnimated];
            TypeWord.text = @"";

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

#pragma mark - keyboard setting

// Keyboard appear
-(void)keyboardisShown:(NSNotification*)Notif{
    
    NSDictionary* info= [Notif userInfo];
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGSize kbsize= [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    float table_height = self.view.frame.size.height - textView.frame.size.height -[UIApplication sharedApplication].statusBarFrame.size.height;
    
    //TextView should change the Origin to Fit the View
    CGRect frame = textView.frame;
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    frame.origin.y -= kbsize.height;
    textView.frame = frame;
    
    
    //Chat Bubble Table should change the View height
    frame = Table.frame;
    frame.size.height=table_height;
    frame.size.height -= kbsize.height;
    Table.frame = frame;

    if (table_height >= table_height - kbsize.height)
        [Table scrollBubbleViewToBottomAnimated];
}

// Keyboard hidden
-(void)keyboardisHidden:(NSNotification*)Notif{
    
    NSDictionary* info= [Notif userInfo];
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    CGSize kbsize= [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = textView.frame;
    frame.origin.y += kbsize.height;
    textView.frame = frame;
    
    frame = Table.frame;
    frame.size.height += kbsize.height;
    Table.frame = frame;
}

- (void)returnKB:(id)sender {
    [TypeWord resignFirstResponder];
}

@end
