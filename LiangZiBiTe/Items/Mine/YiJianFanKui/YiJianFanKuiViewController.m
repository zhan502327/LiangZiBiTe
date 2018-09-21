//
//  YiJianFanKuiViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/19.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "YiJianFanKuiViewController.h"
#import "ZZYPhotoHelper.h"

@interface YiJianFanKuiViewController ()

@property (weak, nonatomic) IBOutlet UITextView *fanKuiTextView;

@property (weak, nonatomic) IBOutlet UITextField *personLabel;
@property (weak, nonatomic) IBOutlet UITextField *mobileLabell;
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;

@property (nonatomic, strong) NSData *imageData;

@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *mobileStr;



@end

@implementation YiJianFanKuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LightHexColcor;

    
    [self setNavgiationBarTitle:@"意见反馈"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logImageViewClicked)];
    
    [self.logImageView addGestureRecognizer:tap];
    
    [self.personLabel addTarget:self action:@selector(personLabelClicked:) forControlEvents:UIControlEventEditingChanged];
    [self.mobileLabell addTarget:self action:@selector(mobileLabelClicked:) forControlEvents:UIControlEventEditingChanged];

    
    
}


- (void)personLabelClicked:(UITextField *)text{
    self.nameStr = text.text;
    
    
}

- (void)mobileLabelClicked:(UITextField *)text{
    self.mobileStr = text.text;
    
    
}

- (void)logImageViewClicked{
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
        self.logImageView.image = [UIImage imageWithData:imagedata];
        self.imageData = imagedata;
        
    }];
    
}

- (IBAction)commitButtonCLicked:(id)sender {
    
    if (self.fanKuiTextView.text.length == 0) {
        PopInfo(@"请输入反馈内容");
        return;
    }
    
    
    if (self.nameStr.length == 0) {
        PopInfo(@"请输入姓名");
        return;
    }
    
    
    if (self.mobileStr.length == 0) {
        PopInfo(@"请输入电话号码");
        return;
    }
    
    
    if (self.imageData.length == 0) {
        PopInfo(@"请上传凭证");
        return;
    }
    
    
    PopLoading(@"提交中");
    [App_HttpsRequestTool yiJianFanKuiWithcontent:self.fanKuiTextView.text fklxr:self.nameStr fklxfs:self.mobileStr fkpic:self.imageData Success:^(id responseObject) {
        PopDismiss;
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            
            PopSuccess(@"反馈成功");
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
        }else{
            
            PopInfo(failMsg);
        }
        
    } failure:^(NSError *error) {
        PopDismiss;
        PopError(netError);
    }];
}



@end
