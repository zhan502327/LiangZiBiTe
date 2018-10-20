//
//  MarketOrderModel.h
//  JianZuLianApp
//
//  Created by zhang shuai on 2017/12/5.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketOrderProductModel.h"

@protocol MarketOrderProductModel
@end

@interface MarketOrderModel : JSONModel


@property (nonatomic, copy) NSString <Optional> *consignee_address;
@property (nonatomic, copy) NSString <Optional> *consignee_mobile;
@property (nonatomic, copy) NSString <Optional> *consignee_realname;
@property (nonatomic, copy) NSString <Optional> *consignee_tel;
@property (nonatomic, copy) NSString <Optional> *consignee_zip;
@property (nonatomic, copy) NSString <Optional> *create_ip;
@property (nonatomic, copy) NSString <Optional> *create_time;
@property (nonatomic, copy) NSString <Optional> *express_fee;
@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *is_delete;
@property (nonatomic, copy) NSString <Optional> *logistics_id;
@property (nonatomic, strong) NSArray <MarketOrderProductModel> *makprod;
@property (nonatomic, copy) NSString <Optional> *order_sn;
@property (nonatomic, copy) NSString <Optional> *pay_total;
@property (nonatomic, copy) NSString <Optional> *pay_type;
@property (nonatomic, copy) NSString <Optional> *product_count;
@property (nonatomic, copy) NSString <Optional> *shop_id;
@property (nonatomic, copy) NSString <Optional> *shopname;
@property (nonatomic, copy) NSString <Optional> *status;
@property (nonatomic, copy) NSString <Optional> *time_end;
@property (nonatomic, copy) NSString <Optional> *total;
@property (nonatomic, copy) NSString <Optional> *transaction_id;
@property (nonatomic, copy) NSString <Optional> *union_sn;
@property (nonatomic, copy) NSString <Optional> *user_id;
@property (nonatomic, copy) NSString <Optional> *realname;
@property (nonatomic, copy) NSString <Optional> *nickname;
@property (nonatomic, copy) NSString <Optional> *evaluateStatus;



@end
