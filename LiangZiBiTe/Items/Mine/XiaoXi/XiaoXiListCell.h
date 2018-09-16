//
//  XiaoXiListCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiaoXiModel.h"

@interface XiaoXiListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic, strong) XiaoXiModel *model;
@end
