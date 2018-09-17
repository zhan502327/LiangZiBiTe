//
//  MaiChuVipInfoResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MaiChuVipInfoModel.h"

@interface MaiChuVipInfoResponse : BaseResponse

@property (nonatomic, strong) MaiChuVipInfoModel <Optional> *data;

@end
