//
//  MineFooterView.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MineFooterView.h"

@implementation MineFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)loginoutButtonClicked:(id)sender {

    if (_loginoutButtonBlock) {
        _loginoutButtonBlock();
    }
}


@end
