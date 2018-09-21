//
//  KuangChiModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KuangChiModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *dqkcs;
@property (nonatomic, copy) NSString <Optional> *countkc;

//dqkcs    int    当前用户矿池数
//countkc    int    总矿池数
@end
