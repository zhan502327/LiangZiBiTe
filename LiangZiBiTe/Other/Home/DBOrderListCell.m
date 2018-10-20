//
//  DBOrderListCell.m
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/1/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "DBOrderListCell.h"

@implementation DBOrderListCell

- (void)setModel:(MarketOrderProductModel *)model{
    
    _model = model;
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[UIImage imageNamed:@"App_OrderList_Image_PlaceHolder"]];
    
    _productNameLabel.text = model.product_name;
    
    _productNumLabel.text = [NSString stringWithFormat:@"X %@",model.num];
    
    _productPriceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
    _standardLabel.text = model.attrvaluename;
//    订单状态0：未付款，1：已付款，2：已发货，3交易成功，4：交易关闭
    if ([model.status intValue] == 0) {
        _productStatusImageView.image = [UIImage imageNamed:@"App_Order_OrderList_waitting"];
        _productStatusLabel.text = @"等待付款";
    }else if ([model.status intValue] == 1){
        _productStatusImageView.image = [UIImage imageNamed:@"App_Order_OrderList_waitting"];
        _productStatusLabel.text = @"等待卖家发货";
    }else if ([model.status intValue] == 2){
        _productStatusImageView.image = [UIImage imageNamed:@"App_Order_OrderList_waitting"];
        _productStatusLabel.text = @"等待买家收货";
    }else if ([model.status intValue] == 3){
        _productStatusImageView.image = [UIImage imageNamed:@"App_Order_OrderList_success"];
        _productStatusLabel.text = @"交易成功";
    }else{
        _productStatusImageView.image = [UIImage imageNamed:@"App_Order_OrderList_success"];
        _productStatusLabel.text = @"交易关闭";
    }
    
}

@end
