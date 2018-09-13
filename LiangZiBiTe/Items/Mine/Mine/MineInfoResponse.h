//
//  MineInfoResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MineInfoModel.h"

@interface MineInfoResponse : BaseResponse

@property (nonatomic, copy) MineInfoModel *data;

@end
