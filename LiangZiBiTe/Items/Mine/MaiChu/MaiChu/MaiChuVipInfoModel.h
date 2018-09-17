//
//  MaiChuVipInfoModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MaiChuVipInfoModel : JSONModel


@property (nonatomic, copy) NSString <Optional> *zzname;
@property (nonatomic, copy) NSString <Optional> *kaihh;
@property (nonatomic, copy) NSString <Optional> *ckr;
@property (nonatomic, copy) NSString <Optional> *kahao;
@property (nonatomic, copy) NSString <Optional> *sjhm;
@property (nonatomic, copy) NSString <Optional> *zfbzh;
@property (nonatomic, copy) NSString <Optional> *wxzh;

//zzname    类型    银行名称
//kaihh    类型    开户行
//ckr    类型    收款人姓名
//kahao    类型    银行卡账号
//sjhm    类型    收款人手机号码
//zfbzh    类型    支付宝账号
//wxzh    类型    微信账号



@end
