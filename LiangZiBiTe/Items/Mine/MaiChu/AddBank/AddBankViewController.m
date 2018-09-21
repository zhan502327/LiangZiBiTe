//
//  AddBankViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AddBankViewController.h"

@interface AddBankViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangTextField;
@property (weak, nonatomic) IBOutlet UITextField *zhifubaoTextfield;
@property (weak, nonatomic) IBOutlet UITextField *weixinTextField;

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = LightHexColcor;

    [self setNavgiationBarTitle:@"添加银行卡"];
    
}


- (IBAction)commitButtonClicked:(id)sender {
    
    [self.view endEditing:YES];
    if (self.nameTextField.text.length == 0) {
        
        PopInfo(@"请输入持卡人姓名");
        return;
    }
    
    if (self.mobileTextField.text.length == 0) {
        
        PopInfo(@"请输入持卡人电话");
        return;
    }
    
    if (self.bankTextField.text.length == 0) {
        
        PopInfo(@"请输入银行名称");
        return;
    }
    
    if (self.kaihuhangTextField.text.length == 0) {
        
        PopInfo(@"请输入开户行");
        return;
    }
    
    if (self.cardNumTextField.text.length == 0) {
        
        PopInfo(@"请输入银行卡号");
        return;
    }
    
    if (self.zhifubaoTextfield.text.length == 0) {
        
        PopInfo(@"请输入支付宝账号");
        return;
    }
    
    if (self.weixinTextField.text.length == 0) {
        
        PopInfo(@"请输入微信账号");
        return;
    }
    
    
    [App_HttpsRequestTool addBankListWithzzname:self.bankTextField.text kaihh:self.kaihuhangTextField.text ckr:self.nameTextField.text kahao:self.cardNumTextField.text sjhm:self.mobileTextField.text zfbzh:self.zhifubaoTextfield.text wxzh:self.weixinTextField.text Success:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] init];
        if ([response isSuccess]) {
            
            PopSuccess(@"完善收款信息成功");
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
            if (self->_refreshDataAfterBankInfoBlock) {
                self->_refreshDataAfterBankInfoBlock();
            }
            
        }else{
            PopInfo(failMsg);
            
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
    
//    参数名    必选    说明
//    id    类型    用户id
//    zzname    类型    银行名称
//    kaihh    类型    开户行
//    ckr    类型    收款人姓名
//    kahao    类型    银行卡账号
//    sjhm    类型    收款人手机号码
//    zfbzh    类型    支付宝账号
//    wxzh    类型    微信账号
//
}

@end
