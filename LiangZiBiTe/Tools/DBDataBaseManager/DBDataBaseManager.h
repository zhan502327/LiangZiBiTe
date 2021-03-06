//
//  DBDataBaseManager.h
//  FMDB_Test
//
//  Created by zhang shuai on 2018/1/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XiaoXiModel.h"

#import "FMDatabase.h"


@interface DBDataBaseManager : NSObject

@property (nonatomic, strong) FMDatabase *db;


+ (DBDataBaseManager *)shareDataBaseManager;


#pragma mark -- 增
- (void)insertNotificationModel:(XiaoXiModel *)model tableName:(NSString *)tableName;
#pragma mark -- 删
- (void)deleteNotificationModel:(XiaoXiModel *)model tableName:(NSString *)tableName;
#pragma mark -- 改
//- (void)updateNotificationModel:(XiaoXiModel *)model tableName:(NSString *)tableName;
#pragma mark -- 点击cell 修改为已读
- (void)updateNotificationModel:(XiaoXiModel *)model tableName:(NSString *)tableName WithIsLooked:(NSString *)isLooked;
#pragma mark -- 查
- (NSArray *)queryAllNotificationModelWithtableName:(NSString *)tableName;
#pragma mark -- 查询指定的数据
- (NSArray *)queryIsLookedCountWithTableName:(NSString *)tableName;
#pragma mark -- 根据id 查询是否已读
- (XiaoXiModel *)queryIsLookedOrNotWithTableName:(NSString *)tableName model:(XiaoXiModel *)model;
#pragma mark -- 删除数据表
- (void)deleteTableWithtableName:(NSString *)tableName;
@end
