//
//  DBOrderListCell.h
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/1/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketOrderProductModel.h"

@interface DBOrderListCell : UITableViewCell

@property (nonatomic, strong) MarketOrderProductModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *productStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productStatusImageView;
@property (weak, nonatomic) IBOutlet UILabel *standardLabel;

@end
