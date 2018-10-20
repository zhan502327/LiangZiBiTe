//
//  DBProductListResponse.h
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/7.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "DBProductListPageModel.h"


@interface DBProductListResponse : BaseResponse

@property (nonatomic, strong) DBProductListPageModel <Optional> *result;

@end
