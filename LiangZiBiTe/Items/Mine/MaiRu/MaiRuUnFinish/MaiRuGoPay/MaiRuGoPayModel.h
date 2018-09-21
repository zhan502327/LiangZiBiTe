//
//  MaiRuGoPayModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MaiRuGoPayModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *kaihh;
@property (nonatomic, copy) NSString <Optional> *phone;
@property (nonatomic, copy) NSString <Optional> *shrxm;
@property (nonatomic, copy) NSString <Optional> *sid;
@property (nonatomic, copy) NSString <Optional> *skfs;
@property (nonatomic, copy) NSString <Optional> *skrsjhm;
@property (nonatomic, copy) NSString <Optional> *skzh;
@property (nonatomic, copy) NSString <Optional> *username;
@property (nonatomic, copy) NSString <Optional> *wxzh;
@property (nonatomic, copy) NSString <Optional> *xingji;
@property (nonatomic, copy) NSString <Optional> *zfbzh;

//skfs    类型    银行名称
//kaihh    类型    开户行
//shrxm    类型    收款人姓名
//skzh    类型    收款账号
//skrsjhm    类型    收款人手机号码
//zfbzh    类型    支付宝账号
//wxzh    类型    微信账号

@end
