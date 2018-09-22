//
//  TuiGuangModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TuiGuangModel : JSONModel


@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *pid;
@property (nonatomic, copy) NSString <Optional> *phone;
@property (nonatomic, copy) NSString <Optional> *username;
@property (nonatomic, copy) NSString <Optional> *xingji;

//"id": 10,
//"pid": "FVTMIIB4",
//"phone": "18501017873",
//"username": "危机的小土豆",
//"xingji": "0"

//id    int    用户id
//pid    int    直推人推广码
//username    int    昵称
//phone    int    账户
//xingji    int    星级
//count    int    总直推数
//countqkt    int    总业绩

@end
