//
//  TuiGuangCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiGuangCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *zhuTuiLabel;
@property (weak, nonatomic) IBOutlet UILabel *ceTuiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yaoQingCodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;

@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;


@property (nonatomic, copy) void(^zhuTuiBlock)();
@property (nonatomic, copy) void(^ceTuiBlock)();
@end
