
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
- (void)loginLoginRequestMobile:(NSString *)phone password:(NSString *)password withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/index/login");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:phone forKey:@"phone"];
    [dic setValue:password forKey:@"password"];
    
//    phone    是    string    手机号码
//    password    是    string    登录密码

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 用户注册
- (void)registerUserWithphone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd repwd:(NSString *)repwd yqm:(NSString *)yqm withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/index/register");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:phone forKey:@"phone"];
    [dic setValue:code forKey:@"code"];
    [dic setValue:pwd forKey:@"pwd"];
    [dic setValue:repwd forKey:@"repwd"];
    [dic setValue:yqm forKey:@"yqm"];
    
//    参数名    必选    类型    说明
//    phone    是    string    手机号码
//    code    是    string    短信验证码
//    pwd    是    string    密码
//    repwd    是    string    重复密码
//    yqm    是    string    邀请码
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//发送验证码
-(void) sendCodeWithphone:(NSString *)phone withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/index/sencode");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:phone forKey:@"phone"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ---- 提交实名认证信息
- (void)commitShiMingInfoWithid:(NSString *)userid rname:(NSString *)rname sfzhm:(NSString *)sfzhm sfzzm:(NSData *)sfzzm sfzbm:(NSData *)sfzbm withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/myindex/upsmxx");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:userid forKey:@"id"];
    [dic setValue:rname forKey:@"rname"];
    [dic setValue:sfzhm forKey:@"sfzhm"];

//    必选    类型    说明
//    id    是    string    用户id
//    rname    是    string    姓名
//    sfzhm    是    string    身份证号码
//    sfzzm    是    string    身份证正面照片
//    sfzbm    是    string    身份证背面照片
    
    [App_HttpsRequestManager upLoadShenFenZhengWithurl:url card_face:sfzzm card_back:sfzbm andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
}

//  ------ 判断是否已经实名认证 
- (void)configShiMingRenZhengWithID:(NSString *)user_id withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/myindex/issmrz");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:user_id forKey:@"id"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



#pragma mark - **************** 首页
// ----- 首页
- (void)appShouyewithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/appindex/index");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}











#pragma mark - **************** 个人信息
//// ------ 获取个人信息
//- (void)personuserInfoWithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
//    
//    NSString *url = App_Api_Base_Url(@"/member/getUserInfo");
//    NSMutableDictionary *dic = [NSMutableDictionary new];
//    [dic setValue:[App_UserManager uid] forKey:@"uid"];
//    
//    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
//        success(responseObject);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//    
//}


// ----- 编辑修改个人信息
- (void)editPersonInfoWithImageData:(NSData *)imageData url:(NSString *)ssurl type:(NSString *)type value:(NSString *)value WithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
//    头像，type 选 a
//    姓名，type 选 n
//    姓别，type 选 s
//    电话，type 选 p

    
    NSString *url = App_Api_Base_Url(ssurl);
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
 

    if ([type isEqualToString:@"a"]) {
        [App_HttpsRequestManager configPersonAvatarWithUrl:url imageData:imageData andParameterDictionary:dic withSuccess:^(id responseObject) {
            success(responseObject);
            
        } failure:^(NSError *error) {
            failure(error);
            
        }];
    }else{
        [dic setValue:value forKey:@"username"];

        [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
        }];
        
    }
}


// ------ 上传身份证
- (void)upLoadShenFenZhengWithtruename:(NSString *)truename IDcard:(NSString *)IDcard card_face:(NSData *)card_face card_back:(NSData *)card_back WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/uploadUserCards");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:truename forKey:@"truename"];
    [dic setObject:IDcard forKey:@"IDcard"];
    [dic setObject:[App_UserManager uid] forKey:@"uid"];


    
    [App_HttpsRequestManager upLoadShenFenZhengWithurl:url card_face:card_face card_back:card_back andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
}


// ------ 上传学生证
- (void)upLoadStudentInfoWithtruename:(NSString *)truename school:(NSString *)school std_number:(NSString *)std_number std_face:(NSData *)std_face WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/uploadUserStdCard");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:truename forKey:@"truename"];
    [dic setObject:school forKey:@"school"];
    [dic setObject:std_number forKey:@"std_number"];
    [dic setObject:std_face forKey:@"std_face"];
    [dic setObject:[App_UserManager uid] forKey:@"uid"];
    
    [App_HttpsRequestManager upLoadStudentInfoWithurl:url std_face:std_face andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];

}



// ----- 地址列表
- (void)addressListWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/addressList");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[App_UserManager uid] forKey:@"uid"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 新增地址
- (void)addNewAddressWithname:(NSString *)name phone:(NSString *)phone province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address is_default:(NSString *)is_default WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/addUserAddress");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[App_UserManager uid] forKey:@"uid"];
    [dic setObject:name forKey:@"name"];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:province forKey:@"province"];
    [dic setObject:city forKey:@"city"];
    [dic setObject:area forKey:@"area"];
    [dic setObject:address forKey:@"address"];
    [dic setObject:is_default forKey:@"is_default"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ------ 我的二维码
- (void)myQRCodeWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/makeMyQrcode");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}








// ------选择 省/市/县（区）
- (void)chooseCityListRequestForParent_id:(NSString *)parent_id withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/getChildRegion");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (parent_id.length == 0) {
        [dic setObject:@"0" forKey:@"parent_id"];
    }else{
        [dic setObject:parent_id forKey:@"parent_id"];
    }
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ----- 获取银行卡列表
- (void)bankListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/getUserBankCard");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[App_UserManager uid] forKey:@"uid"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------ 新增银行卡
- (void)addNewBankWithname:(NSString *)name IDcard:(NSString *)IDcard bank:(NSString *)bank account:(NSString *)account phone:(NSString *)phone Success:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/addUserBankCard");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[App_UserManager uid] forKey:@"uid"];
    [dic setValue:name forKey:@"name"];
    [dic setValue:IDcard forKey:@"IDcard"];
    [dic setValue:bank forKey:@"bank"];
    [dic setValue:account forKey:@"account"];
    [dic setValue:phone forKey:@"phone"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}














#pragma mark - **************** 我的
// ----- 我的
- (void)minedataWithsuccess:(getBackBlock)success failure:(getFailBlock)failure{
    NSString *url = App_Api_Base_Url(@"/index.php/api/myindex/usermsg");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

// ---- 判断是否可以平台买入
- (void)mineConfigIsShowPingTaiMaiRusuccess:(getBackBlock)success failure:(getFailBlock)failure{
    NSString *url = App_Api_Base_Url(@"/index.php/api/lzbtjy/isnolzbt");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

// ---- 我的 - QKT 量子比特
- (void)mineQKTAndLiangZiBiTeWithtype:(NSString *)type success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/myindex/mxjllist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    [dic setValue:type forKey:@"type"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


// --- 转入
- (void)mineZhuanRusuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/lzbtjy/lzbgmsg");
    NSMutableDictionary *dic = [NSMutableDictionary new];
 
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//----- 转出
- (void)mineZhuanChuWithphone:(NSString *)phone qkd:(NSString *)qkd success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdzc/qkdzc");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"aid"];
    [dic setValue:phone forKey:@"phone"];
    [dic setValue:qkd forKey:@"qkd"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


// ---- 买入 - 创建订单
- (void)mineMaiRuCreateOrderjye:(NSString *)jye success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmr/createdd");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    [dic setValue:jye forKey:@"jye"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


//---- 消息列表
- (void)xiaoXiListWithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/myindex/usermessage");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


// ----- 母币买入
- (void)muBiMaiRuCommitWithqbdzje:(NSString *)qbdzje jtpz:(NSData *)jtpz bzpz:(NSString *)bzpz Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/myindex/usermessage");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    [dic setValue:qbdzje forKey:@"qbdzje"];
    [dic setValue:bzpz forKey:@"bzpz"];

    //必选    类型    说明
    //id    是    string    用户id
    //qbdzje    是    string    转账数量（或金额）
    //jtpz    是    string    截图凭证
    //bzpz    是    string    备注信息
    
    
    
    [App_HttpsRequestManager mubimairuCommitWithUrl:url imageData:jtpz andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
    
}

// ----- 复投
- (void)mineFuTouWithqkd:(NSString *)qkd WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/futou/futou");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    [dic setValue:qkd forKey:@"qkd"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ---- 买入 - 未完成订单 - 未选择收款人
- (void)mineMaiRuUnfinishOrderUnSelectOrderWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmr/mrddlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ---- 卖出 - 未完成订单 - 未选择收款人
- (void)maichuUnfinshUnselectOrderWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmc/mrddlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ---- 买入 - 未完成订单 - 未选择收款人 - 取消订单
- (void)mineMaiRuUnselectOrderCancelWithOrderID:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmr/qxwxzshr");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:orderid forKey:@"id"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ---- 卖出 - 未完成订单 - 未选择收款人 - 取消订单
- (void)mineMaiChuUnselectOrderCancelWithOrderID:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmc/qxwxzshr");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:orderid forKey:@"id"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



// ---- 买入 - 未完成订单 - 已选择收款人  已选择、确认、完成
- (void)mineMaiRuUnfinishOrderSelectSureFinishOrderWithType:(NSString *)type Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmr/mryqwlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    [dic setValue:type forKey:@"type"];

    
//    type    是    string    列表类型， 2已选择收款人，3待确认打款（等待对方确认收款），4已完成订单（确认完成）
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


// ---- 卖出 - 未完成订单 - 已选择收款人  已选择、确认、完成
- (void)mineMaiChuUnfinishOrderSelectSureFinishOrderWithType:(NSString *)type Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmc/mryqwlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    [dic setValue:type forKey:@"type"];
    
    
//type    是    string    列表类型， 2已选择打款人（等待对方打款），3待确认收款（确认收款），4已完成订单（确认完成）
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}





// ---- 买入 - 未完成订单 - 已选择收款人  已选择、确认、完成  - 取消订单
- (void)mineMaiRuUnfinishSelectOrderCanceWithOrderid:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmr/qxhf1");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:orderid forKey:@"id"];


    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

// ---- 卖出 - 未完成订单 - 已选择收款人  已选择、确认、完成  - 取消订单
- (void)mineMaiChuUnfinishSelectOrderCanceWithOrderid:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmc/qxhf1");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:orderid forKey:@"id"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



// ---- 卖出 - 创建订单
- (void)maichuCreateOrderWithjye:(NSString *)jye Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmc/createdd");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    [dic setValue:jye forKey:@"jye"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


// ----- 卖出 - 会员信息
- (void)maichuVIPinfoWithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmc/zhanghumsg");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[App_UserManager uid] forKey:@"id"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}



// ---- 卖出中心 列表
- (void)mineMaiChuCenterListWithjine:(NSString *)jine Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    
    NSString *url = App_Api_Base_Url(@"/index.php/api/qkdmc/mrzxlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:jine forKey:@"jine"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}




















#pragma mark - **************** 商城
// ------ 商城首页-banner
- (void)marketBannerRequestWithType:(NSString *)type WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/banner");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:type forKey:@"goods"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//商品列表
- (void)marketProductListWithpage:(int)page pagesize:(int)pagesize category:(NSString *)category WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/goodslist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:category forKey:@"category"];
    [dic setValue:[NSNumber numberWithInt:page] forKey:@"page"];
    [dic setValue:[NSNumber numberWithInt:pagesize] forKey:@"pagesize"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------ 商城首页最新列表和热门列表
- (void)marketHotListAndNewListRequestWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Goods/index");
    NSMutableDictionary *dic = [NSMutableDictionary new];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------ 商品详情
- (void)marketDetailWithgoods_id:(NSString *)goods_id tWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/detail");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:goods_id forKey:@"goods_id"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ----- 积分兑换
- (void)jifenDuihuanWithgood_id:(NSString *)good_id WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/fuli/duihuan");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:good_id forKey:@"good_id"];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ------ 订单结算
- (void)orderSureresult:(NSString *)result Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/order/makeorder");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];
    [dic setValue:result forKey:@"result"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



// ----- 立即购买 /order/add
- (void)goBuyNowWithids:(NSString *)ids buynum:(NSString *)buynum address_id:(NSString *)address_id attrvalueid:(NSString *)attrvalueid paytype:(NSString *)paytype Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/order/add");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];
    [dic setValue:ids forKey:@"ids"];//商品id例如id=”3,4”
    [dic setValue:buynum forKey:@"buynum"];//buynum=”3,2”
    [dic setValue:address_id forKey:@"address_id"];
    [dic setValue:attrvalueid forKey:@"attrvalueid"];
    [dic setValue:paytype forKey:@"paytype"];//支付方式 二选一 wx alipay

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



// ------ 点击规格 获取价格
- (void)clickProductCategoryGetPriceWithgoods_id:(NSString *)goods_id attrvalue_id:(NSString *)attrvalue_id Success:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/getrealgood");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:goods_id forKey:@"goods_id"];
    [dic setObject:attrvalue_id forKey:@"attrvalue_id"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------添加购物车
- (void)marketShoppingCarAddProductRequestDataForProduct_id:(NSString *)product_id buynum:(NSString *)buynum price:(NSString *)price goods_attr_store_id:(NSString *)goods_attr_store_id attrvalue_id:(NSString *)attrvalue_id remark:(NSString *)remark withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/add");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];
    [dic setValue:product_id forKey:@"good_id"];
    [dic setValue:buynum forKey:@"buynum"];
    [dic setValue:price forKey:@"price"];
    [dic setValue:remark forKey:@"remark"];//备注
    [dic setValue:goods_attr_store_id forKey:@"goods_attr_store_id"];
    [dic setValue:attrvalue_id forKey:@"attrvalue_id"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 购物车列表
- (void)carListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/carlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];

    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}



// ------改变商品数量
- (void)marketChangeProductNumRequestDataForProduct_id:(NSString *)product_id buyNum:(NSString *)buyNum withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/edit");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];
    [dic setObject:product_id forKey:@"good_store_id"];
    [dic setObject:buyNum forKey:@"buynum"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ------删除购物车商品
- (void)marketShoppingCarListDeleteProductWithproduct_sn:(NSString *)product_sn withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/del");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];
    [dic setObject:product_sn forKey:@"good_store_id"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}










#pragma mark - **************** 福利
// ------ 福利首页
- (void)welfareListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/fuli/index");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}








#pragma mark - **************** 推广
// ------  推广首页
- (void)extentionwithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/fuli/tuiguang");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[App_UserManager uid] forKey:@"uid"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


@end
