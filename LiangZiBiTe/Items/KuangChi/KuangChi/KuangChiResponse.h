//
//  KuangChiResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "KuangChiModel.h"



@interface KuangChiResponse : BaseResponse

@property (nonatomic, strong) KuangChiModel <Optional> *data;

@end
