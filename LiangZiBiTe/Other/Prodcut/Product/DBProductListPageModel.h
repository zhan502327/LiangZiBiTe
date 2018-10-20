//
//  DBProductListPageModel.h
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/8.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "PageModel.h"
#import "DBProductListModel.h"

@protocol DBProductListModel
@end

@interface DBProductListPageModel : PageModel

@property (nonatomic, strong) NSArray <DBProductListModel> *items;

@end
