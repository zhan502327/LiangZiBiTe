//
//  QKDModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QKDModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *uid;
@property (nonatomic, copy) NSString <Optional> *suliang;
@property (nonatomic, copy) NSString <Optional> *liayuan;
@property (nonatomic, copy) NSString <Optional> *type;
@property (nonatomic, copy) NSString <Optional> *ztime;


//类型    说明
//uid    int    用户id
//suliang    int    收支数量
//liayuan    int    来源
//type    int    类型，1量子比特2qkd
//ztime    int    时间


@end
