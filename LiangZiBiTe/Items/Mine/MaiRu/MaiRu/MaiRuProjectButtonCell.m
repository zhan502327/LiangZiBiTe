//
//  MaiRuProjectButtonCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuProjectButtonCell.h"

@implementation MaiRuProjectButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self selectView];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
}

- (SixProjectSelectButtonView *)selectView{
    if (_selectView == nil) {
        SixProjectSelectButtonView *view = [[SixProjectSelectButtonView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:view];
        _selectView = view;
    }
    return _selectView;
}

@end
