
//
//  HttpsRequestTool.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/9.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "HttpsRequestTool.h"
#import "HttpsRequestManager.h"



#define App_Api_Base_Url(url) [NSString stringWithFormat:@"%@%@",cnUrl,url]

static HttpsRequestTool *shareHttpsRequestTool = nil;

@implementation HttpsRequestTool

+ (HttpsRequestTool *)shareHttpsRequestTool {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareHttpsRequestTool = [[self alloc] init];
        
    });
    return shareHttpsRequestTool;
}




#pragma mark - **************** 登陆注册
// ------密码登陆
- (void)loginLoginRequestMobile:(NSString *)mobile passWord:(NSString *)passWord deviceID:(NSString *)deviceId withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/user/dologin");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:mobile forKey:@"username"];
    [dic setValue:passWord forKey:@"password"];
    [dic setValue:@"" forKey:@"jpush_id"];
    [dic setValue:deviceId forKey:@"device_id"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 用户注册
- (void)registerUserWithphone:(NSString *)phone password:(NSString *)password pid:(NSString *)pid withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Member/regisiter");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:phone forKey:@"username"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:pid forKey:@"pid"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



#pragma mark - **************** 首页
// ----- 首页

- (void)textWithDic:(NSDictionary *)param withSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    
    NSString *urlStr = @"/assets_history.php";

    NSString *url = [@"http://app.connel.cn/api/" stringByAppendingFormat:@"%@",urlStr];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:param withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}









#pragma mark - **************** 个人信息










#pragma mark - **************** 我的








@end
