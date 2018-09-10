//
//  SelectMoneyTipsView.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "SelectMoneyTipsView.h"

@implementation SelectMoneyTipsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"SelectMoneyTipsView" owner:nil options:nil] lastObject];
        self.frame = frame;
    }
    return self;
}

@end
