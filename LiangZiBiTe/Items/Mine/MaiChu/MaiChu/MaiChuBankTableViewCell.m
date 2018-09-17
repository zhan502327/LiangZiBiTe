//
//  MaiChuBankTableViewCell.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiChuBankTableViewCell.h"

@implementation MaiChuBankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MaiChuVipInfoModel *)model{
    _model = model;
    
//    @property (weak, nonatomic) IBOutlet UIView *noBankView;
//    @property (weak, nonatomic) IBOutlet UIView *haveBankView;
//    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *bankLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *zhifubaoLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *weixinLabel;
    
    
    //zzname    类型    银行名称
    //kaihh    类型    开户行
    //ckr    类型    收款人姓名
    //kahao    类型    银行卡账号
    //sjhm    类型    收款人手机号码
    //zfbzh    类型    支付宝账号
    //wxzh    类型    微信账号
    
    if (model) {
        
        _haveBankView.hidden = NO;
        
        _noBankView.hidden = YES;
        
        _nameLabel.text = [NSString stringWithFormat:@"姓名：%@",model.ckr];
        
        _mobileLabel.text = [NSString stringWithFormat:@"手机号：%@",model.sjhm];
        
        _bankLabel.text = [NSString stringWithFormat:@"银行卡号：%@",model.kahao];
        
        _zhifubaoLabel.text = [NSString stringWithFormat:@"支付宝号：%@",model.zfbzh];
        
        _weixinLabel.text = [NSString stringWithFormat:@"微信号：%@",model.wxzh];
        
    }else{
        
        _haveBankView.hidden = YES;
        
        _noBankView.hidden = NO;
    }
    
    
    
}

@end
