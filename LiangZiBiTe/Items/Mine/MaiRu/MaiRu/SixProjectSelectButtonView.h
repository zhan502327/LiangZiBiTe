//
//  SixProjectSelectButtonView.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixProjectSelectButtonView : UIView
@property (weak, nonatomic) IBOutlet UIView *contentView;



@property (weak, nonatomic) IBOutlet UIButton *createOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *unFinishOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet UIButton *centerButton;

@property (nonatomic, strong) NSArray *buttonTitleArray;


@property (nonatomic, copy) void(^oneButtonBlock)();
@property (nonatomic, copy) void(^twoButtonBlock)();
@property (nonatomic, copy) void(^threeButtonBlock)();
@property (nonatomic, copy) void(^fourButtonBlock)();
@property (nonatomic, copy) void(^fiveButtonBlock)();
@property (nonatomic, copy) void(^sixButtonBlock)();


@end
