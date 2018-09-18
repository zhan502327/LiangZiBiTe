//
//  MaiChuCenterCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaiChuCenterModel.h"

@interface MaiChuCenterCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *logImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyiLabel;
@property (weak, nonatomic) IBOutlet UILabel *shifuLabel;

@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (nonatomic, copy) void(^sellButtonBlock)(void);

@property (weak, nonatomic) IBOutlet UIButton *sellButton;

@property (nonatomic, strong) MaiChuCenterModel *model;


@end
