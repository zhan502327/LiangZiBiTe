
//
//  MaiRuFinishCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuFinishCell.h"

@implementation MaiRuFinishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MaiRuUnSelectListModel *)model{
    _model = model;
    
    //    @property (weak, nonatomic) IBOutlet UIImageView *logImageView;
    //    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    //    @property (weak, nonatomic) IBOutlet UIView *starView;
    //    @property (weak, nonatomic) IBOutlet UILabel *jiaoyiLabel;
    //    @property (weak, nonatomic) IBOutlet UILabel *shifuLabel;
    
    //id    int    订单id
    //uid    int    用户id
    //jye    int    购买数量
    //sfkje    int    实付款金额
    //username    int    用户昵称
    //pic    int    头像路径
    //xingji    int    信用星级
    
    
    [_logImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    _nameLabel.text = model.username;
    
    _starLabel.text = [NSString stringWithFormat:@"x%@",ADDOBJECT(model.xingji)];
    
    _jiaoyiLabel.text = model.jye;
    
    _shifuLabel.text = model.sfkje;
    
    
    
}

@end
