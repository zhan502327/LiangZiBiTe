//
//  MarketOrderResponse.h
//  JianZuLianApp
//
//  Created by zhang shuai on 2017/12/5.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "BaseResponse.h"
#import "MarketOrderPageModel.h"

@interface MarketOrderResponse : BaseResponse

@property (nonatomic, strong) MarketOrderPageModel <Optional> *result;

@end
