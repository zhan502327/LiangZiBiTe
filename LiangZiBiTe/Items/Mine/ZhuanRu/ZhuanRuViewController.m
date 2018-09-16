//
//  ZhuanRuViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ZhuanRuViewController.h"
#import "ZhuanRuResponse.h"
#import "CreateQRCode.h"

@interface ZhuanRuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;

@end

@implementation ZhuanRuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"转入"];
    

    [self createQRCode];
    
}

- (void)createQRCode{
    
    
    self.logImageView.image = [CreateQRCode createQRCodeWithString:[NSString stringWithFormat:@"qkd%@",[App_UserManager phone]] withLength:300];
    
    
}


@end
