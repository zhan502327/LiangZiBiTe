//
//  MaiRuProjectButtonCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SixProjectSelectButtonView.h"


@interface MaiRuProjectButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, weak) SixProjectSelectButtonView *selectView;



@end
