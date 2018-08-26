//
//  HttpsRequestTool.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/9.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <Foundation/Foundation.h>


// ------获取数据成功返回Block
typedef void (^getBackBlock)(id responseObject);
// ------获取数据失败返回Block
typedef void (^getFailBlock)(NSError *error);

#define App_HttpsRequestTool [HttpsRequestTool shareHttpsRequestTool]

@interface HttpsRequestTool : NSObject

+ (HttpsRequestTool *)shareHttpsRequestTool;




#pragma mark - **************** 登陆注册
// ------密码登陆
- (void)loginLoginRequestMobile:(NSString *)mobile passWord:(NSString *)passWord deviceID:(NSString *)deviceId withSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 用户注册
- (void)registerUserWithphone:(NSString *)phone password:(NSString *)password pid:(NSString *)pid withSuccess:(getBackBlock)success failure:(getFailBlock)failure;



#pragma mark - **************** 首页
// ----- 首页
- (void)textWithDic:(NSDictionary *)param withSuccess:(getBackBlock)success failure:(getFailBlock)failure;







@end
