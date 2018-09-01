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

@end
