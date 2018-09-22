//
//  TuiGuangData.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TuiGuangModel.h"


@protocol TuiGuangModel
@end


@interface TuiGuangData : JSONModel

@property (nonatomic, strong) NSArray <TuiGuangModel> *array;

@property (nonatomic, copy) NSString <Optional> *count;

@property (nonatomic, copy) NSString <Optional> *countqkt;


@end
