//
//  DBDataBaseManager.m
//  FMDB_Test
//
//  Created by zhang shuai on 2018/1/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "DBDataBaseManager.h"



static DBDataBaseManager *manager = nil;

@implementation DBDataBaseManager

+ (DBDataBaseManager *)shareDataBaseManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[DBDataBaseManager alloc] init];
        
        [manager createDataBase];
        [manager createTableWithTableName:kNotificationOne];
//        [manager createTableWithTableName:kNotificationTwo];
//        [manager createTableWithTableName:kNotificationThree];

    });
    
    return manager;
}

#pragma mark -- 创建数据库
- (void)createDataBase{
    

    //获取沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = [doc stringByAppendingPathComponent:@"notificationModel.sqlite"];
    
    //创建数据库
    self.db = [FMDatabase databaseWithPath:filePath];
    
    NSLog(@"filePath     %@",filePath);
    
}


#pragma mark -- 创建表
- (void)createTableWithTableName:(NSString *)tableName{
    if ([self.db open]) {
//        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id varchar(256) PRIMARY KEY NOT NULL, isLooked varchar(256) NOT NULL, alert_id varchar(256), explain varchar(256), device_id varchar(256), station varchar(256), alert_type_name varchar(256), happen_time varchar(256), a_id varchar(256), asset varchar(256))",tableName];
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id varchar(256) PRIMARY KEY NOT NULL, isLooked varchar(256) NOT NULL)",tableName];

        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            NSLog(@"创建 %@ 成功",tableName);
        }else{
            NSLog(@"创建 %@ 失败",tableName);
        }
        [self.db close];
    }else{
        NSLog(@"创建表 - 数据库打开失败");
    }
}

#pragma mark -- 增
- (void)insertNotificationModel:(XiaoXiModel *)model tableName:(NSString *)tableName{
    if ([self.db open]) {
//        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (id, isLooked, alert_id, explain, device_id, station, alert_type_name, happen_time, a_id, asset) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",tableName ,model.id, model.isLooked, model.alert_id, model.explain, model.device_id, model.station, model.alert_type_name, model.happen_time, model.a_id, model.asset];

        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (id, isLooked) VALUES ('%@', '%@')",tableName ,model.id, @"0"];

        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            NSLog(@"插入数据成功");
        }else{
            NSLog(@"插入数据失败");
//            [self updateNotificationModel:model tableName:tableName];
        }
        [self.db class];
    }else{
        NSLog(@"插入数据 - 数据库打开失败");
    }
}
#pragma mark -- 删
- (void)deleteNotificationModel:(XiaoXiModel *)model tableName:(NSString *)tableName{
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = %@",tableName , model.id];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            NSLog(@"删除数据成功");
        }else{
            NSLog(@"删除数据失败");
        }
    }else{
        NSLog(@"删除数据 - 数据库打开失败");
    }
}



#pragma mark -- 改
//- (void)updateNotificationModel:(YWEventModel *)model tableName:(NSString *)tableName{
//    if ([self.db open]) {
//
//        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET alert_id = '%@', explain = '%@', device_id = '%@', station = '%@', alert_type_name = '%@', happen_time = '%@', a_id = '%@', asset = '%@' WHERE id = '%@'",tableName , model.alert_id, model.explain, model.device_id, model.station, model.alert_type_name, model.happen_time, model.a_id, model.asset, model.id];
//
//
//        BOOL result = [self.db executeUpdate:sql];
//
//        if (result) {
//            NSLog(@"修改数据成功");
//        }else{
//            NSLog(@"修改数据失败");
//        }
//
//    }else{
//        NSLog(@"修改数据 - 数据库打开失败");
//    }
//}

#pragma mark -- 点击cell 修改为已读
- (void)updateNotificationModel:(XiaoXiModel *)model tableName:(NSString *)tableName WithIsLooked:(NSString *)isLooked{
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET isLooked = '%@' WHERE id = '%@'",tableName, isLooked, model.id];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            NSLog(@"修改数据成功");
        }else{
            NSLog(@"修改数据失败");
        }
    }else{
        NSLog(@"修改数据 - 数据库打开失败");
    }
}


#pragma mark -- 查询全部数据
- (NSArray *)queryAllNotificationModelWithtableName:(NSString *)tableName{
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
        FMResultSet *set = [self.db executeQuery:sql];
        while ([set next]) {
            NSString *notificationID = [set stringForColumn:@"id"];
            NSString *isLooked = [set stringForColumn:@"isLooked"];


            XiaoXiModel *model = [[XiaoXiModel alloc] init];
            model.id = notificationID;
            model.isLooked = isLooked;
            
            [resultArray addObject:model];
        }
    }else{
        NSLog(@"查询数据 - 数据库打开失败");
    }
    return resultArray;
}

#pragma mark -- 查询指定的数据
- (NSArray *)queryIsLookedCountWithTableName:(NSString *)tableName{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE isLooked = '%@'",tableName ,@"0"];
        FMResultSet *set = [self.db executeQuery:sql];
        while ([set next]) {
            NSString *notificationID = [set stringForColumn:@"id"];
            NSString *isLooked = [set stringForColumn:@"isLooked"];

            
            XiaoXiModel *model = [[XiaoXiModel alloc] init];
            model.id = notificationID;
            model.isLooked = isLooked;

            
            
            if (model.id.length > 0) {
                [array addObject:model];
            }
            
        }
    }else{
        NSLog(@"查询指定数据 - 数据库打开失败");
    }
    return array;
}
#pragma mark -- 根据id 查询是否已读
- (XiaoXiModel *)queryIsLookedOrNotWithTableName:(NSString *)tableName model:(XiaoXiModel *)model{
    XiaoXiModel *resultModel = [[XiaoXiModel alloc] init];

    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE id = '%@'",tableName , model.id];
        FMResultSet *set = [self.db executeQuery:sql];
        if ([set next]) {
            NSString *notificationID = [set stringForColumn:@"id"];
            NSString *isLooked = [set stringForColumn:@"isLooked"];
     
            
            resultModel.id = notificationID;
            resultModel.isLooked = isLooked;
        
            
        }else{
            resultModel = nil;
        }
    }else{
        NSLog(@"查询指定数据 - 数据库打开失败");
        resultModel = nil;
    }
    return resultModel;
    
}


#pragma mark -- 删除数据表
- (void)deleteTableWithtableName:(NSString *)tableName{
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", tableName];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            NSLog(@"删除数据表成功");
        }else{
            NSLog(@"删除数据表失败");
        }
    }else{
        NSLog(@"查询数据 - 数据库打开失败");
    }
}

@end
