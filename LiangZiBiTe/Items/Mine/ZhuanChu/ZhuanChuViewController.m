//
//  ZhuanChuViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ZhuanChuViewController.h"

//扫描二维码
#import "LBXScanViewStyle.h"
#import "DIYScanViewController.h"
#import "StyleDIY.h"
#import "Global.h"
#import "QQLBXScanViewController.h"

@interface ZhuanChuViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;

@end

@implementation ZhuanChuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LightHexColcor;


    [self setNavgiationBarTitle:@"转出"];

}
- (IBAction)scanButtonClicked:(id)sender {
    
    //添加一些扫码或相册结果处理
    QQLBXScanViewController *vc = [QQLBXScanViewController new];
    vc.libraryType = [Global sharedManager].libraryType;
    vc.scanCodeType = [Global sharedManager].scanCodeType;
    vc.style = [StyleDIY qqStyle];
    //镜头拉远拉近功能
    vc.isVideoZoom = YES;
    
    [vc setRefreshZhuanChuBlock:^(NSString *scanResult) {
       
        NSString *result = [scanResult stringByReplacingOccurrencesOfString:@"qkd" withString:@""];
        
        self.textField.text = result;
        
    }];
    
    [self.rt_navigationController pushViewController:vc animated:YES];
}
- (IBAction)nextButtonClicked:(id)sender {
    
    if (self.textField.text.length == 0) {
        
        PopInfo(@"请输入对方账户");
        return;
    }
    
    if (self.numTextField.text.length == 0) {
        
        PopInfo(@"请输入转出数量");
        return;
    }
    
    
    [App_HttpsRequestTool mineZhuanChuWithphone:self.textField.text qkd:self.numTextField.text success:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            PopSuccess(@"转出成功");
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
        }else{
            PopInfo(failMsg);
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
    
}

@end
