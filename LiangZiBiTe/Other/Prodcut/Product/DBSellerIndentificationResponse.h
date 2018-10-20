//
//  DBSellerIndentificationResponse.h
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/6.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "DBSellerIdentificationModel.h"

@interface DBSellerIndentificationResponse : BaseResponse

@property (nonatomic, strong) DBSellerIdentificationModel <Optional> *result;

@end
