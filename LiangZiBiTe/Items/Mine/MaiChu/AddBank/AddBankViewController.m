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

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"添加银行卡"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
        
        PopInfo(@"请输入开户行");
        return;
    }
    
    if (self.cardNumTextField.text.length == 0) {
        
        PopInfo(@"请输入卡号");
        return;
    }
    
}

@end
