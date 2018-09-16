//
//  MuBiMaiRuResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MuBiMaiRuModel.h"

@interface MuBiMaiRuResponse : BaseResponse

@property (nonatomic, strong) MuBiMaiRuModel <Optional> *data;

@end
