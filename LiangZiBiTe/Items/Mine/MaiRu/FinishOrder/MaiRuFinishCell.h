//
//  MaiRuFinishCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaiRuUnSelectListModel.h"

@interface MaiRuFinishCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyiLabel;
@property (weak, nonatomic) IBOutlet UILabel *shifuLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;

@property (nonatomic, copy) void(^payButtonBlock)(void);

@property (nonatomic, strong) MaiRuUnSelectListModel *model;


@end
