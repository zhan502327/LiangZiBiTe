//
//  XiaoXiListCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "XiaoXiListCell.h"

@implementation XiaoXiListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(XiaoXiModel *)model{
    _model = model;
    
    _titleLabel.text = model.title;
    
    _contentLabel.text = model.content;
    
    _timeLabel.text = [Utility timeWithTimeIntervalString:model.addtime];
    
}

@end
