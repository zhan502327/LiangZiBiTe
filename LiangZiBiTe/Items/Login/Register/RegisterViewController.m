//
//  RegisterViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/12.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserInfoModel.h"
#import "LoginViewController.h"
#import "UserInfoResponse.h"
#import "UIImage+Color.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"注册"];

    self.navigationController.navigationBar.hidden = YES;
    
    
    [self.mobileTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordAgainTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    
    
    UIColor *topColor = HexColor(0X7099FE);
    
    UIColor *bottomColor = HexColor(0X3171FE);
    
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topColor, bottomColor] gradientType:GradientTypeLeftToRight imgSize:self.registerButton.frame.size];
    
    [self.registerButton  setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    
}

- (IBAction)sendCodeButtonClicked:(id)sender {
    
    
    
    
}
- (IBAction)registerButtonClicked:(id)sender {
    
    if (self.mobileTextField.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入手机号"];
        return;
    }
    
//    if (self.codeTextField.text.length == 0) {
//
//        [SVProgressHUDManager popTostInfoWithString:@"请输入验证码"];
//        return;
//    }
    
    if (self.passwordTextfield.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入密码"];
        return;
    }
    
//    [App_HttpsRequestTool registerUserWithphone:self.mobileTextField.text password:self.passwordTextfield.text pid:self.scanModel.uid withSuccess:^(id responseObject) {
//        
//        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
//        if ([response isSuccess]) {
//            //注册成功清除上个用户的信息
//            [UserInfoManager cleanUserInfo];
//            
//            UserInfoModel *model = [[UserInfoModel alloc] init];
//            model.username = self.mobileTextField.text;
//            UserInfoManager.userModel = model;
//            
//            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
//       
//            [SVProgressHUDManager popTostSuccessWithString:@"恭喜您注册成功"];
//        }else{
//            
//            [SVProgressHUDManager popTostErrorWithString:response.reason];
//        }
//        
//    } failure:^(NSError *error) {
//        [SVProgressHUDManager popTostErrorWithString:netError];
//    }];
    
}
- (IBAction)selectButtonClicekd:(id)sender {
}
- (IBAction)userHelpButtonClicked:(id)sender {
}
- (IBAction)popButtonCLicekd:(id)sender {
    
    [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
}

@end
