//
//  ShouKuanInfoModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ShouKuanInfoModel : JSONModel


@property (nonatomic, copy) NSString <Optional> *beizhu;
@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *pztp;
@property (nonatomic, copy) NSString <Optional> *qrtime;

//id    int    订单id
//pztp    int    截图凭证
//beizhu    int    备注
//qrtime    int    打款时间



@end
