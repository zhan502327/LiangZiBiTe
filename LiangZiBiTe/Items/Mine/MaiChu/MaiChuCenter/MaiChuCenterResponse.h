//
//  MaiChuCenterResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MaiChuCenterModel.h"

@protocol MaiChuCenterModel
@end

@interface MaiChuCenterResponse : BaseResponse

@property (nonatomic, strong) NSArray <MaiChuCenterModel>*data;

@end
