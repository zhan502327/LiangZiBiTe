//
//  MarketOrderPageModel.h
//  JianZuLianApp
//
//  Created by zhang shuai on 2017/12/5.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "PageModel.h"
#import "MarketOrderModel.h"

@protocol MarketOrderModel
@end
@interface MarketOrderPageModel : PageModel


@property (nonatomic, strong) NSArray <MarketOrderModel> *items;

@end
