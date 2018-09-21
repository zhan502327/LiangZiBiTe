//
//  ShouKuanInfoViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ShouKuanInfoViewController.h"
#import "YiJianFanKuiViewController.h"
#import "ShouKuanInfoResponse.h"
#import "UserInfoResponse.h"

@interface ShouKuanInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;

@property (nonatomic, strong) ShouKuanInfoModel *model;

@end

@implementation ShouKuanInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LightHexColcor;

    
    [self setNavgiationBarTitle:@"收款信息"];
    
    
    [self loadData];
    
}


- (void)loadData{
    
    [App_HttpsRequestTool maichuSureOrderShouKuanInfoWithorderid:self.orderid Success:^(id responseObject) {
        
        ShouKuanInfoResponse *response = [[ShouKuanInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            
            self.model = response.data;
            
            self.contentLabel.text = self.model.beizhu;
            
            [self.logImageView sd_setImageWithURL:[NSURL URLWithString:self.model.pztp]];
            
        }else{
            
        }
        
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}


- (IBAction)tousuButtonClicked:(id)sender {
    
    YiJianFanKuiViewController *vc = [[YiJianFanKuiViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
}
- (IBAction)shoukuanBUttonClicked:(id)sender {
    
    [self showAlertViewWithType:AlertTypePassword title:@"请输入登录密码"];

    
}

#pragma mark -- 显示弹框
- (void)showAlertViewWithType:(AlertType)type title:(NSString *)title{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        if (userNameTextField.text.length == 0) {
            return ;
        }
        
        switch (type) {
            case AlertTypePassword:
                
                [self configPasswordWithText:userNameTextField.text];
                
                
                break;
                
            case AlertTypeNum:
                
                //                [self configFuTouNumWithNum:userNameTextField.text];
                
                
                break;
                
                
                
                
            default:
                break;
        }
        
        
        
    }]];
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
        
        textField.placeholder = title;
        switch (type) {
            case AlertTypePassword:
                
                textField.secureTextEntry=YES;
                
                break;
                
                
            case AlertTypeNum:
                
                textField.keyboardType = UIKeyboardTypeNumberPad;
                
                break;
            default:
                break;
        }
        
        
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark -- 验证支付密码
- (void)configPasswordWithText:(NSString *)text{
    [App_HttpsRequestTool loginLoginRequestMobile:[App_UserManager phone] password:text withSuccess:^(id responseObject) {
        
        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self sureShouKuan];
            
        }else{
            PopInfo(failMsg);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}

- (void)sureShouKuan{
    
    PopLoading(@"收款中");
    [App_HttpsRequestTool mineSureOrderInfoSureShouKuanActionWithOrderid:self.orderid Success:^(id responseObject) {
        PopDismiss;
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response  isSuccess]) {
            
            PopSuccess(response.msg);
            
            if (self->_refreshDataSureBlock) {
                self->_refreshDataSureBlock();
            }
            
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
        }else{
            
        }
        
    } failure:^(NSError *error) {
        PopDismiss;
        PopError(netError);
    }];
    
    
}

@end
