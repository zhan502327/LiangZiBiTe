//
//  MaiRuUnSelectedCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuUnSelectedCell.h"

@implementation MaiRuUnSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cancelButtonCLicked:(id)sender {
    if (_cancelButtonBlock) {
        _cancelButtonBlock();
    }
}

@end
