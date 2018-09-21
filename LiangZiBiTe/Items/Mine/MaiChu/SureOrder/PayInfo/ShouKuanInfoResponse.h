//
//  ShouKuanInfoResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "ShouKuanInfoModel.h"


@interface ShouKuanInfoResponse : BaseResponse

@property (nonatomic, strong) ShouKuanInfoModel <Optional> *data;

@end


