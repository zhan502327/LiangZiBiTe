//
//  MaiRuGoPayViewController.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"

@interface MaiRuGoPayViewController : BaseViewController

@property (nonatomic, copy) NSString *orderid;

@property (nonatomic, copy) void(^refreshDataAfterPay)();

@end
