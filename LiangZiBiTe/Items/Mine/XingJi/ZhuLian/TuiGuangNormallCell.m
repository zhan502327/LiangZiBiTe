//
//  TuiGuangNormallCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "TuiGuangNormallCell.h"

@implementation TuiGuangNormallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TuiGuangModel *)model{
    _model = model;
    
    _mobileLabel.text = model.phone;
    
    _starLabel.text = [NSString stringWithFormat:@"x%@",model.xingji];
    
}

@end
