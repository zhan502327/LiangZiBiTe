//
//  MaiChuBankTableViewCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaiChuVipInfoModel.h"

@interface MaiChuBankTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *noBankView;
@property (weak, nonatomic) IBOutlet UIView *haveBankView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhifubaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *weixinLabel;

@property (nonatomic, strong) MaiChuVipInfoModel *model;

@end
