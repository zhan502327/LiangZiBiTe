//
//  MuBiNextViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MuBiNextViewController.h"
#import "ZZYPhotoHelper.h"

@interface MuBiNextViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mairuNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *beizhuTextField;
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;

@property (nonatomic, copy) NSString *numStr;
@property (nonatomic, copy) NSString *beizhuStr;
@property (nonatomic, strong) NSData *imageData;



@end

@implementation MuBiNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"买入"];
    
    
    [self.mairuNumTextField addTarget:self action:@selector(mairuNumTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];
    
    [self.beizhuTextField addTarget:self action:@selector(beizhuTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logImageViewClicked)];
    
    [self.logImageView addGestureRecognizer:tap];
    
}

- (void)mairuNumTextFieldClicked:(UITextField *)textField{
    self.numStr = textField.text;
    
    
}


- (void)beizhuTextFieldClicked:(UITextField *)textField{
    self.beizhuStr = textField.text;
    
    
}

- (void)logImageViewClicked{
    
//    WeakSelf;
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
        self.logImageView.image = [UIImage imageWithData:imagedata];
        self.imageData = imagedata;
        
    }];
    
}



- (IBAction)commitButtonCLicked:(id)sender {
    
    if (self.numStr.length == 0) {
        PopInfo(@"请输入买入数量");
        return;
    }
    
    
    if (self.beizhuStr.length == 0) {
        PopInfo(@"请输入备注信息");
        return;
    }
    
    if (self.imageData.length == 0) {
        PopInfo(@"请上传截图凭证");
        return;
    }
    
    PopLoading(@"买入中");
    [App_HttpsRequestTool muBiMaiRuCommitWithqbdzje:self.numStr jtpz:self.imageData bzpz:self.beizhuStr Success:^(id responseObject) {
        PopDismiss;
        BaseResponse *response =[[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            PopSuccess(@"母币买入成功");
            
        }else{
            PopInfo(response.msg);
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
        PopDismiss;
    }];
    
}

@end
