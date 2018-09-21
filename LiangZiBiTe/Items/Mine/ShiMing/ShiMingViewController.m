//
//  ShiMingViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ShiMingViewController.h"
#import "ZZYPhotoHelper.h"


@interface ShiMingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fanmianImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zhengmianImageView;

@property (nonatomic, strong) NSData *zmData;
@property (nonatomic, strong) NSData *fmData;

@end

@implementation ShiMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LightHexColcor;

    
    [self setNavgiationBarTitle:@"实名认证"];
    
    
    UITapGestureRecognizer *tapone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zhengmianClicked)];
    
    [self.zhengmianImageView addGestureRecognizer:tapone];
    
    
    UITapGestureRecognizer *taptwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fanmianClicked)];
    
    [self.fanmianImageView addGestureRecognizer:taptwo];
    
}


- (void)zhengmianClicked{
    
    WeakSelf;
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
        self.zmData = imagedata;
        weakSelf.zhengmianImageView.image = [UIImage imageWithData:imagedata];
    }];
    
}


- (void)fanmianClicked{
    
    WeakSelf;
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
        self.fmData = imagedata;
        weakSelf.fanmianImageView.image = [UIImage imageWithData:imagedata];
    }];
    
}
- (IBAction)commitButtonClicked:(id)sender {
    
    if (self.zmData.length == 0) {
        PopInfo(@"请上传身份证正面照片");
        return;
    }
    
    if (self.fmData.length == 0) {
        PopInfo(@"请上传身份证反面照片");
        return;
    }
    
    
    PopLoading(@"提交中");
    [App_HttpsRequestTool commitShiMingInfoWithid:[App_UserManager uid] rname:@"" sfzhm:@"" sfzzm:self.zmData sfzbm:self.fmData withSuccess:^(id responseObject) {
        PopDismiss;
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"提交成功");
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
