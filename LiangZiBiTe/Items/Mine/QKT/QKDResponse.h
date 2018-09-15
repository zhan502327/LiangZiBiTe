//
//  QKDResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "QKDModel.h"

@protocol QKDModel
@end

@interface QKDResponse : BaseResponse

@property (nonatomic, strong) NSArray <QKDModel> *data;

@end
