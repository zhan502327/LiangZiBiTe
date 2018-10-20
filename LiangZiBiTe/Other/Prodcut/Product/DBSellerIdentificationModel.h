//
//  DBSellerIdentificationModel.h
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/6.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "JSONModel.h"

@interface DBSellerIdentificationModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *logo;
@property (nonatomic, copy) NSString <Optional> *shop_id;
@property (nonatomic, copy) NSString <Optional> *status;

@end
