//
//  TuiGuangResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "TuiGuangData.h"


@interface TuiGuangResponse : BaseResponse


@property (nonatomic, strong) TuiGuangData <Optional> *data;


@end
