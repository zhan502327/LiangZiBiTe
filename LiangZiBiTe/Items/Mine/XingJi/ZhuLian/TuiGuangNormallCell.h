//
//  TuiGuangNormallCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuiGuangModel.h"

@interface TuiGuangNormallCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;

@property (nonatomic, strong) TuiGuangModel *model;

@end
