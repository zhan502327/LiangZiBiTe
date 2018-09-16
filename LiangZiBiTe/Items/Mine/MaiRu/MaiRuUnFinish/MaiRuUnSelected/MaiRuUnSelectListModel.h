//
//  MaiRuUnSelectListModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MaiRuUnSelectListModel : JSONModel


@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *jye;
@property (nonatomic, copy) NSString <Optional> *pic;
@property (nonatomic, copy) NSString <Optional> *sfkje;
@property (nonatomic, copy) NSString <Optional> *state;
@property (nonatomic, copy) NSString <Optional> *type;
@property (nonatomic, copy) NSString <Optional> *uid;
@property (nonatomic, copy) NSString <Optional> *username;
@property (nonatomic, copy) NSString <Optional> *xingji;





//id = 38;
//jye = 1000;
//pic = "http://115.47.126.105:10010/uploads/apifile/20180914/48cea3b5f72d7f49e8c5fd0183fc241a.";
//sfkje = 850;
//state = 1;
//type = 1;
//uid = 8;
//username = "\U58a8\U8ff9\U4e86";
//xingji = 1;

//id    int    订单id
//uid    int    用户id
//jye    int    购买数量
//sfkje    int    实付款金额
//username    int    用户昵称
//pic    int    头像路径
//xingji    int    信用星级


//id    int    订单id
//state    int    订单状态，2已选择收款人，3待确认打款（等待对方确认收款），4已完成订单（确认完成）
//jye    int    购买数量
//sfkje    int    实付款金额
//username    int    用户昵称
//pic    int    头像路径
//xingji    int    信用星级

@end
