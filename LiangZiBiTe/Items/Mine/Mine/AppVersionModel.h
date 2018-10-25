//
//  AppVersionModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/10/25.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AppVersionModel : JSONModel

//"id": 1,
//"version": "1",
//"downloadurl": "http:\/\/114.202.245.34\/appurl\/app-debug.apk",
//"content": "系统自动升级"
//"iversion": "1.0.0"

@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *version;
@property (nonatomic, copy) NSString <Optional> *downloadurl;
@property (nonatomic, copy) NSString <Optional> *content;
@property (nonatomic, copy) NSString <Optional> *iversion;


@end
