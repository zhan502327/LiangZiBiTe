//
//  AddBankViewController.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"

@interface AddBankViewController : BaseViewController

@property (nonatomic, copy) void(^refreshDataAfterBankInfoBlock)();

@end
