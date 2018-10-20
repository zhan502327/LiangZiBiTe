//
//  DBProductListCell.h
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/7.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBProductListModel.h"

@interface DBProductListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productSoldNunLabel;
@property (weak, nonatomic) IBOutlet UILabel *productSaveLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic, strong) DBProductListModel *model;

@property (nonatomic, copy) void(^actionButtonBlock)(void);
@property (nonatomic, copy) void(^deleteButtonBlock)(void);

@end
