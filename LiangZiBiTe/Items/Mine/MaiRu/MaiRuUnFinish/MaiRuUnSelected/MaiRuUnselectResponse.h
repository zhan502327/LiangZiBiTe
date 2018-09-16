//
//  MaiRuUnselectResponse.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MaiRuUnSelectListModel.h"

@protocol MaiRuUnSelectListModel
@end

@interface MaiRuUnselectResponse : BaseResponse

@property (nonatomic, strong) NSArray <MaiRuUnSelectListModel> *data;

@end
