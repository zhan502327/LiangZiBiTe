//
//  MaiRuGoPayResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MaiRuGoPayModel.h"

@interface MaiRuGoPayResponse : BaseResponse

@property (nonatomic, strong) MaiRuGoPayModel <Optional> *data;

@end
