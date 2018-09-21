//
//  MaiRuGoPayCommitCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuGoPayCommitCell.h"

@implementation MaiRuGoPayCommitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)commitButtonCLicked:(id)sender {
    
    if (_commitButtonBlock) {
        _commitButtonBlock();
    }
    
}

@end
