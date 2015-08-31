//
//  SCRegViewController.m
//  Simple_Chat
//
//  Created by 蔡繼東 on 2015/8/29.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SCRegViewController.h"


@interface SCRegViewController ()

@end

@implementation SCRegViewController

@synthesize Age, Avatar, Gender, User_name, Password, NickName, Register, imgURL, Avatarbtn;

- (void)viewDidLoad {
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat view_h = self.view.frame.size.height;
    CGFloat view_w = self.view.frame.size.width;
    
    CGFloat Label_h = view_h/20;
    CGFloat Label_w = view_w/2;
    
    // setting items frame
    Avatar = [[UIImageView alloc] initWithFrame:CGRectMake( view_w/4, view_h/10, view_w/2 , view_w/2)];
    Avatar.image = [UIImage imageNamed:@"avatar.png"];
    Avatar.userInteractionEnabled = YES;
    Avatarbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Avatarbtn setFrame:CGRectMake(0, 0, Avatar.frame.size.width, Avatar.frame.size.height)];
    [Avatarbtn setBackgroundColor:[UIColor clearColor]];
    [Avatarbtn addTarget:self action:@selector(Camera:) forControlEvents:UIControlEventTouchUpInside];
    [Avatar addSubview:Avatarbtn];
    
    CGFloat Avatar_h = Avatar.frame.origin.y + Avatar.frame.size.height;
    
    User_name = [[UITextField alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + Label_h , Label_w, Label_h )];
    User_name.delegate = self;
    [User_name setFont:[UIFont fontWithName:@"Futura" size:20]];
    User_name.placeholder = @"User_Name";
    [User_name setTextColor:[UIColor whiteColor]];
    [User_name setTextAlignment:NSTextAlignmentCenter];
    User_name.backgroundColor = [UIColor grayColor];
    
    Password = [[UITextField alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + 3*Label_h , Label_w, Label_h )];
    Password.delegate = self;
    [Password setFont:[UIFont fontWithName:@"Futura" size:20]];
    Password.placeholder = @"Password";
    [Password setTextColor:[UIColor whiteColor]];
    [Password setTextAlignment:NSTextAlignmentCenter];
    Password.backgroundColor = [UIColor grayColor];
    
    
    NickName = [[UITextField alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + 5*Label_h , Label_w, Label_h )];
    NickName.delegate = self;
    [NickName setFont:[UIFont fontWithName:@"Futura" size:20]];
    NickName.placeholder = @"Nickname";
    [NickName setTextColor:[UIColor whiteColor]];
    [NickName setTextAlignment:NSTextAlignmentCenter];
    NickName.backgroundColor = [UIColor grayColor];
    
    Age = [[UITextField alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + 7*Label_h , Label_w, Label_h )];
    Age.placeholder = @"Age";
    Age.delegate = self;
    [Age setFont:[UIFont fontWithName:@"Futura" size:20]];
    [Age setTextColor:[UIColor whiteColor]];
    [Age setTextAlignment:NSTextAlignmentCenter];
    Age.backgroundColor = [UIColor grayColor];
    
    Gender = [[UITextField alloc] initWithFrame:CGRectMake(view_w/4, Avatar_h + 9*Label_h , Label_w, Label_h )];
    Gender.placeholder = @"Gender";
    [Gender setFont:[UIFont fontWithName:@"Futura" size:20]];
    [Gender setTextColor:[UIColor whiteColor]];
    [Gender setTextAlignment:NSTextAlignmentCenter];
    Gender.backgroundColor = [UIColor grayColor];
    
    Register = [UIButton buttonWithType:UIButtonTypeCustom];
    Register.frame = CGRectMake(view_w/4, Avatar_h + 11*Label_h , Label_w, Label_h);
    Register.backgroundColor = [UIColor darkGrayColor];
    [Register.titleLabel setFont:[UIFont fontWithName:@"Futura" size:20]];
    Register.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Register setTitle:@"Register" forState:UIControlStateNormal];
    [Register addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:User_name];
    [self.view addSubview:Password];
    [self.view addSubview:Avatar];
    [self.view addSubview:NickName];
    [self.view addSubview:Age];
    [self.view addSubview:Gender];
    [self.view addSubview:Register];
    [self addPickerView];
    
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

#pragma mark - PickerView

-(void)DoneClick:(id)sender{
    if (Gender.text.length ==0) {
        Gender.text = [genderArray objectAtIndex:0];
    }
    [genderView removeFromSuperview];
    [Gender resignFirstResponder];
    [self addPickerView];
}

-(void)addPickerView{
    
    genderArray = [[NSArray alloc] initWithObjects:@"boy",@"girl", nil];
    genderView = [[UIPickerView alloc]init];
    Gender.delegate = self;
    genderView.dataSource = self;
    genderView.delegate = self;
    genderView.showsSelectionIndicator = YES;
    Gender.inputView = genderView;
    UIToolbar *doneBar = [[UIToolbar alloc] init];
    doneBar.barStyle = UIBarStyleBlack;
    doneBar.translucent= YES;
    [doneBar sizeToFit];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(DoneClick:)];
    doneBtn.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [doneBar setItems:[NSArray arrayWithObjects:flexibleSpace,doneBtn, nil]];
    Gender.inputAccessoryView = doneBar;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return row==0?@"boy":@"girl";
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger IntegerforReturn = 1;
    IntegerforReturn = (NSInteger)[genderArray count];
    return IntegerforReturn;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    Gender.text = [genderArray objectAtIndex:row];
}

#pragma mark - Register

-(void) Register:(id) sender{

    //*** Should upload image and get imgURL before POST
    imgURL = @"https://www.drupal.org/files/profile_default.jpg";
    
    if (!User_name.text || !Password.text || !Age.text || !Gender.text || !NickName.text) {
        
        UIAlertView* errorView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
            message:@"Please fill in all datas."
                delegate:self   cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
        [errorView show];
    }
    
    NSNumber *gender = [Gender.text isEqualToString:@"boy"]?@1:@0;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSNumber *age = [NSNumber numberWithInt:Age.text.intValue];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:User_name.text,@"user_name", Password.text, @"password",imgURL,@"avatar",  NickName.text , @"display_name",gender, @"gender",  age,@"age",nil];
    
    [manager POST:@"http://104.155.215.148:5566/signup" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] isEqualToNumber:@1]) {
            //store datas
            SCInfoViewController *vc = [[SCInfoViewController alloc] init];
            vc.user_name = [User_name.text lowercaseString];
            vc.password = [Password.text lowercaseString];
            [[self navigationController] pushViewController:vc animated:NO];
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


#pragma mark - Camera -> change Avatar

- (void)Camera:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select your Photo source"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    NSUInteger buttonCount = 0;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:@"Camera"];
        ++buttonCount;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [actionSheet addButtonWithTitle:@"Photo Library"];
        ++buttonCount;
    }
    
    [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.cancelButtonIndex = buttonCount;
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([buttonTitle isEqualToString:@"Camera"]) {
        
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else if ([buttonTitle isEqualToString:@"Photo Library"]) {
        
        imagePicker.delegate = self;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        //   imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        return;
    }
}

//set image
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        [self scaleAndRotateImage:image];
        
        // present the cropper view controller
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            
        }];
    }];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    CGSize newSize = CGSizeMake(320.0f, 320.0f);
    UIGraphicsBeginImageContext(newSize);
    [editedImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* small = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    Avatar.image = small;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}



//For rotate Image
- (UIImage *)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = 640;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Save failed"
                              message:@"Failed to save image"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
