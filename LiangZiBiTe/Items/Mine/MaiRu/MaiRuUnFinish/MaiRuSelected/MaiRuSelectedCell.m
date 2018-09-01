//
//  MaiRuSelectedCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuSelectedCell.h"

@implementation MaiRuSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)payButtonClicked:(id)sender {
    if (_payButtonBlock) {
        _payButtonBlock();
    }
}
- (IBAction)cancelButtonCLicked:(id)sender {
    if (_cancelButtonBlock) {
        _cancelButtonBlock();
    }
}

@end
