//
//  AppVersionResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/10/25.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "AppVersionModel.h"

@interface AppVersionResponse : BaseResponse

@property (nonatomic, strong) AppVersionModel <Optional> *data;
@property (nonatomic, copy) NSString <Optional> *status;



@end
