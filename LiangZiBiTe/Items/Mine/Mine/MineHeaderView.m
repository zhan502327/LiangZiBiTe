//
//  MineHeaderView.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mairuButton.titleLabel.lineBreakMode = 0;//这句话很重要，不加这句话加上换行符也没用
    self.fuTouButton.titleLabel.lineBreakMode = 0;//这句话很重要，不加这句话加上换行符也没用

    [self.mairuButton setTitle:@"平台\n买入" forState:UIControlStateNormal];
    
    [self.fuTouButton setTitle:@"QKD\n复投" forState:UIControlStateNormal];
    
}




- (IBAction)scanButtonClicked:(id)sender {
    if (_scanButtonBlock) {
        _scanButtonBlock();
    }
}
- (IBAction)leftButtonClicked:(id)sender {
    if (_leftButtonBlock) {
        _leftButtonBlock();
    }
}
- (IBAction)rightButtonCLicked:(id)sender {
    if (_rightButtonBlock) {
        _rightButtonBlock();
    }
}
- (IBAction)mairuButtonCLicked:(id)sender {
    if (_maiRuButtonBlock) {
        _maiRuButtonBlock();
    }
}
- (IBAction)fuTouButtonCLicked:(id)sender {
    if (_futouButtonBlock) {
        _futouButtonBlock();
    }
}

@end
