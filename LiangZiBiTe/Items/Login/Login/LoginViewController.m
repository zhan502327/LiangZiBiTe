//
//  LoginViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserInfoResponse.h"
#import "AppDelegate+UI.h"
#import "AppDelegate.h"
#import "UIImage+Color.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"登录"];
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self.mobileTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];


    
    UIColor *topColor = HexColor(0X7099FE);
    
    UIColor *bottomColor = HexColor(0X3171FE);
    
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topColor, bottomColor] gradientType:GradientTypeLeftToRight imgSize:self.loginButton.frame.size];
    
    [self.loginButton  setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    
 
    
    if (App_UserManager.userModel.username.length > 0) {
        self.mobileTextField.text = App_UserManager.userModel.username;
    }
    
}


- (IBAction)loginButtonClicked:(id)sender {
    
    if (_mobileTextField.text.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入账号"];
        return;
    }

    if (_passwordTextField.text.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入密码"];
        return;

    }

    PopLoading(@"登录中");
    [App_HttpsRequestTool loginLoginRequestMobile:self.mobileTextField.text password:self.passwordTextField.text withSuccess:^(id responseObject) {
        
        PopDismiss;
        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            App_UserManager.userModel = response.data;
            
            [(AppDelegate *)[UIApplication sharedApplication].delegate relinkToRootVC];
            
        }else{
            PopInfo(failMsg);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
        PopDismiss;

    }];

    
}

#pragma mark -- 注册
- (IBAction)registerButtonClicked:(id)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}


#pragma mark -- 忘记密码
- (IBAction)forgetPasswordButtonClicked:(id)sender {
}
@end
