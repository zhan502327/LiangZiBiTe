//
//  MaiRuGoPayPhotoCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuGoPayPhotoCell.h"

@implementation MaiRuGoPayPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked)];
    [self.logImageView addGestureRecognizer:tap];
    
}

- (void)imageViewClicked{
    
    if (_logImageViewBlock) {
        _logImageViewBlock();
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
