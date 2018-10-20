//
//  MarketOrderProductModel.h
//  JianZuLianApp
//
//  Created by zhang shuai on 2017/12/5.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MarketOrderProductModel : JSONModel




@property (nonatomic, copy) NSString <Optional > *id;
@property (nonatomic, copy) NSString <Optional > *num;
@property (nonatomic, copy) NSString <Optional > *order_sn;
@property (nonatomic, copy) NSString <Optional > *price;
@property (nonatomic, copy) NSString <Optional > *product_image;
@property (nonatomic, copy) NSString <Optional > *product_name;
@property (nonatomic, copy) NSString <Optional > *product_sn;
@property (nonatomic, copy) NSString <Optional > *product_spec;
@property (nonatomic, copy) NSString <Optional > *product_type_id;
@property (nonatomic, copy) NSString <Optional > *remark;
@property (nonatomic, copy) NSString <Optional > *total;
@property (nonatomic, copy) NSString <Optional > *status;
@property (nonatomic, copy) NSString <Optional > *evaluateStatus;
@property (nonatomic, copy) NSString <Optional > *attrvaluename;
@property (nonatomic, copy) NSString <Optional > *attrvalueid;

@end
