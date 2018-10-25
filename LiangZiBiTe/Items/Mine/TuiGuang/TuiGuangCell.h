//
//  TuiGuangCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiGuangCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *zhulianButton;

@property (weak, nonatomic) IBOutlet UIButton *celianButton;

@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;

@property (weak, nonatomic) IBOutlet UIView *resultView;


@property (nonatomic, copy) void(^zhuTuiBlock)();
@property (nonatomic, copy) void(^ceTuiBlock)();
@end
