//
//  MaiRuCenterResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MaiRuCenterModel.h"

@protocol MaiRuCenterModel
@end

@interface MaiRuCenterResponse : BaseResponse


@property (nonatomic, strong) NSArray <MaiRuCenterModel> *data;

@end
