//
//  MineHeaderView.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *leftNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightNumLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@property (nonatomic, copy) void(^leftButtonBlock)(void);
@property (nonatomic, copy) void(^rightButtonBlock)(void);
@property (nonatomic, copy) void(^scanButtonBlock)(void);
@property (weak, nonatomic) IBOutlet UIButton *mairuButton;
@property (nonatomic, copy) void(^maiRuButtonBlock)(void);

@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UIButton *fuTouButton;
@property (nonatomic, copy) void(^futouButtonBlock)(void);
@property (weak, nonatomic) IBOutlet UILabel *redLabel;

@end
