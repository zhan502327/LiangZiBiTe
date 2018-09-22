//
//  SystemAdvResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "SystemAdvModel.h"

@interface SystemAdvResponse : BaseResponse

@property (nonatomic, strong) SystemAdvModel <Optional> *data;

@end
