//
//  DBProductListModel.h
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/7.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "JSONModel.h"

@interface DBProductListModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *image;
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *num;

@property (nonatomic, copy) NSString <Optional> *price;
@property (nonatomic, copy) NSString <Optional> *product_sn;
@property (nonatomic, copy) NSString <Optional> *sell_num;
@property (nonatomic, copy) NSString <Optional> *status;
@property (nonatomic, copy) NSString <Optional> *type_id;
//@property (nonatomic, copy) NSString <Optional> *stocknum;




@end
