//
//  DBProductListCell.m
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/7.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "DBProductListCell.h"

@implementation DBProductListCell

//@property (nonatomic, copy) NSString <Optional> *image;
//@property (nonatomic, copy) NSString <Optional> *name;
//@property (nonatomic, copy) NSString <Optional> *price;
//@property (nonatomic, copy) NSString <Optional> *product_sn;
//@property (nonatomic, copy) NSString <Optional> *sell_num;
//@property (nonatomic, copy) NSString <Optional> *status;
//@property (nonatomic, copy) NSString <Optional> *type_id;


- (void)setModel:(DBProductListModel *)model{
    _model = model;
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"App_OrderList_Image_PlaceHolder"]];
    
    _productNameLabel.text = model.name;
    
    _productpriceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
    
    _productSaveLabel.text = [NSString stringWithFormat:@"库存： %@",model.num];
    
    _productSoldNunLabel.text = [NSString stringWithFormat:@"已售： %@",model.sell_num];
    
    if ([model.status isEqualToString:@"1"]) {
        [_actionButton setTitle:@"下架" forState:UIControlStateNormal];
        _actionButton.tag = 101;
    }
    
    if ([model.status isEqualToString:@"0"]) {
        [_actionButton setTitle:@"上架" forState:UIControlStateNormal];
        _actionButton.tag = 100;
        
    }
    
}
- (IBAction)actionButtonClicked:(id)sender {
    if (_actionButtonBlock) {
        _actionButtonBlock();
    }
    
}
- (IBAction)deleteButtonClicked:(id)sender {
    if (_deleteButtonBlock) {
        _deleteButtonBlock();
    }
}

@end
