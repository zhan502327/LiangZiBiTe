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
@property (weak, nonatomic) IBOutlet UITextField *yaoqingmaTextField;

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
    
    if (self.mobileTextField.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入手机号"];
        return;
    }
    
    if (![Utility checkPhone:self.mobileTextField.text]) {
        
        [SVProgressHUDManager popTostErrorWithString:@"手机号输入错误"];
        return;
    }
    
    if (![Utility checkPhone:self.mobileTextField.text]) {
        
        [SVProgressHUDManager popTostErrorWithString:@"手机号输入错误"];
        return;
    }
    
    
    [App_HttpsRequestTool sendCodeWithphone:self.mobileTextField.text withSuccess:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"验证码发送成功 请查收");
            
            [self startTime];
            
        }else{
            
            PopInfo(response.msg);
            
        }
        
    } failure:^(NSError *error) {
        PopInfo(netError);
    }];
    
    
}
- (IBAction)registerButtonClicked:(id)sender {
    
    if (self.mobileTextField.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入手机号"];
        return;
    }
    
    if (self.codeTextField.text.length == 0) {

        [SVProgressHUDManager popTostInfoWithString:@"请输入验证码"];
        return;
    }
    
    if (self.yaoqingmaTextField.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入邀请码"];
        return;
    }

    
    if (self.passwordTextfield.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入密码"];
        return;
    }
    
    if (self.passwordAgainTextField.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请再次输入密码"];
        return;
    }
    
    
    [App_HttpsRequestTool registerUserWithphone:self.mobileTextField.text code:self.codeTextField.text pwd:self.passwordTextfield.text repwd:self.passwordAgainTextField.text yqm:self.yaoqingmaTextField.text withSuccess:^(id responseObject) {
        
        
        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            //注册成功清除上个用户的信息
            [App_UserManager cleanUserInfo];
            
            UserInfoModel *model = [[UserInfoModel alloc] init];
            model.phone = self.mobileTextField.text;
            App_UserManager.userModel = model;
            
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
            [SVProgressHUDManager popTostSuccessWithString:@"恭喜您注册成功"];
        }else{
            PopInfo(response.msg);
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostErrorWithString:netError];

    }];
    
    

    
}
- (IBAction)selectButtonClicekd:(id)sender {
}
- (IBAction)userHelpButtonClicked:(id)sender {
}
- (IBAction)popButtonCLicekd:(id)sender {
    
    [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
}



#pragma mark - **************** 验证码时间计算
- (void)startTime {
    
    __block int timeout = 60;//倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0) {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               //设置界面的按钮显示 根据自己需求设置
                               [self.codeButton setTitleColor:HexColor(0X4189F6) forState:UIControlStateNormal];
                               [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                               self.codeButton.userInteractionEnabled = YES;
                           });
        } else {
            
            int seconds = timeout % 130;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               [self.codeButton setTitleColor:HexColor(0XA2A2A2) forState:UIControlStateNormal];
                               [self.codeButton setTitle:[NSString stringWithFormat:@"%@s重新获取",strTime] forState:UIControlStateNormal];
                               self.codeButton.userInteractionEnabled = NO;
                           });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
