//
//  ShouKuanInfoViewController.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"

@interface ShouKuanInfoViewController : BaseViewController

@property (nonatomic, copy) NSString *orderid;

@property (nonatomic, copy) void(^refreshDataSureBlock)();

@end
