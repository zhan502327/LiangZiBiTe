//
//  XiaoXiResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "XiaoXiModel.h"

@protocol XiaoXiModel
@end


@interface XiaoXiResponse : BaseResponse


@property (nonatomic, strong) NSArray <XiaoXiModel> *data;

@end
