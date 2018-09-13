//
//  MineInfoModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MineInfoModel : JSONModel




@property (nonatomic, copy) NSString <Optional> *id;

/**
 issqz    int    设置是否未社区长 0否 1 是
 */
@property (nonatomic, copy) NSString <Optional> *issqz;

/**
 isstate    int    是否激活 0激活 1未激活
 */
@property (nonatomic, copy) NSString <Optional> *isstate;

/**
 isstop    int    是否封禁0正常 1已封禁
 */
@property (nonatomic, copy) NSString <Optional> *isstop;

/**
 jhtime    int    激活时间
 */
@property (nonatomic, copy) NSString <Optional> *jhtime;

/**
ltgm    int    主链推广码
 */
@property (nonatomic, copy) NSString <Optional> *ltgm;

/**
 lzbt    int    拥有的量子比特
 */
@property (nonatomic, copy) NSString <Optional> *lzbt;

/**
 密码
 */
@property (nonatomic, copy) NSString <Optional> *password;

/**
 //phone    int    会员手机号码
 */
@property (nonatomic, copy) NSString <Optional> *phone;

/**
 //pic    int    头像路径
 */
@property (nonatomic, copy) NSString <Optional> *pic;

/**
 //pid    int    直推推广码
 */
@property (nonatomic, copy) NSString <Optional> *pid;

/**
 qkt    int    拥有的QKD总数
 */
@property (nonatomic, copy) NSString <Optional> *qkt;

/**
 retime    int    注册时间
 */
@property (nonatomic, copy) NSString <Optional> *retime;

/**
 rname    int    姓名
 */
@property (nonatomic, copy) NSString <Optional> *rname;

/**
 rtgm    int    侧链推广码
 */
@property (nonatomic, copy) NSString <Optional> *rtgm;

/**
 sfzbm    int    身份证背面照片
 */
@property (nonatomic, copy) NSString <Optional> *sfzbm;

/**
 身份证背面号码
 */
@property (nonatomic, copy) NSString <Optional> *sfzhm;

/**
 sfzzm    int    身份证正面照片
 */
@property (nonatomic, copy) NSString <Optional> *sfzzm;

/**
 shdz    int    收货地址
 */
@property (nonatomic, copy) NSString <Optional> *shdz;

/**
 username    int    昵称
 */
@property (nonatomic, copy) NSString <Optional> *username;

/**
 xingji    int    星级
 */
@property (nonatomic, copy) NSString <Optional> *xingji;





@end
