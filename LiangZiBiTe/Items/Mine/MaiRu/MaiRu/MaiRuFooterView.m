//
//  MaiRuFooterView.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuFooterView.h"

@implementation MaiRuFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)createOrderButtonClicked:(id)sender {
    if (_createOrderBlock) {
        _createOrderBlock();
    }
}

@end
