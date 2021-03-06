//
//  UserManager.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

#define App_UserManager [UserManager shareUserManager]


@interface UserManager : NSObject

@property (nonatomic, strong) UserInfoModel *userModel;

@property (nonatomic, copy) NSString *status;

//创建单利
+ (UserManager *)shareUserManager;


//获取头像
- (NSString *)avatar;

//获取用户名
- (NSString *)userName;

//获取用户id
- (NSString *)uid;

//获取用户电话
- (NSString *)phone;


//获取主链推广
- (NSString *)zltg;

//获取测链推广
- (NSString *)cltg;

//判断是否登录
- (BOOL)isLogined;

//退出登录
- (void)loginOut;

//清除用户信息
- (void)cleanUserInfo;

//上传身份证信息成功
- (void)isUploadIdCardWithStatus:(BOOL)status;

//获取上传身份证信息状态
- (BOOL)uploadIdCardWithStatus;


//上传学生证信息成功
- (void)isUploadStudentWithStatus:(BOOL)status;

//获取上传学生证信息状态
- (BOOL)uploadStudentWithStatus;



@end
