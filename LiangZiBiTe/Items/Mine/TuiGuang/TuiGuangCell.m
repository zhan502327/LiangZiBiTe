//
//  TuiGuangCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "TuiGuangCell.h"

@implementation TuiGuangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)zhuLiaTuiguangBUttonCLicked:(id)sender {
    if (_zhuTuiBlock) {
        _zhuTuiBlock();
    }
}
- (IBAction)celainTuiGuangButtonClicked:(id)sender {
    if (_ceTuiBlock) {
        _ceTuiBlock();
    }
}

@end
