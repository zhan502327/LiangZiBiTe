//
//  LiangZiBiTeCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "LiangZiBiTeCell.h"

@implementation LiangZiBiTeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setModel:(QKDModel *)model{
    _model = model;
    
    _nameLabel.text = model.liayuan;
    
    _moneyLabel.text = model.suliang;
    
    _timeLabel.text = model.ztime;
    
    
}
@end
