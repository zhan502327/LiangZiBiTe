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
- (void)loginLoginRequestMobile:(NSString *)phone password:(NSString *)password withSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 用户注册
- (void)registerUserWithphone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd repwd:(NSString *)repwd yqm:(NSString *)yqm withSuccess:(getBackBlock)success failure:(getFailBlock)failure;


//------ 发送验证码
-(void) sendCodeWithphone:(NSString *)phone withSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ---- 提交实名认证信息
- (void)commitShiMingInfoWithid:(NSString *)userid rname:(NSString *)rname sfzhm:(NSString *)sfzhm sfzzm:(NSData *)sfzzm sfzbm:(NSData *)sfzbm withSuccess:(getBackBlock)success failure:(getFailBlock)failure;



//  ------ 判断是否已经实名认证 /index.php/api/myindex/issmrz
- (void)configShiMingRenZhengWithID:(NSString *)user_id withSuccess:(getBackBlock)success failure:(getFailBlock)failure;


#pragma mark - **************** 矿池
// ----- 矿池
- (void)kuangchiCountwithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

















#pragma mark - **************** 个人信息
//// ------ 获取个人信息
//- (void)personuserInfoWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 编辑修改个人信息
- (void)editPersonInfoWithImageData:(NSData *)imageData url:(NSString *)ssurl type:(NSString *)type value:(NSString *)value WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ------ 上传身份证
- (void)upLoadShenFenZhengWithtruename:(NSString *)truename IDcard:(NSString *)IDcard card_face:(NSData *)card_face card_back:(NSData *)card_back WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;



// ------ 上传学生证
- (void)upLoadStudentInfoWithtruename:(NSString *)truename school:(NSString *)school std_number:(NSString *)std_number std_face:(NSData *)std_face WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 地址列表
- (void)addressListWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ----- 新增地址
- (void)addNewAddressWithname:(NSString *)name phone:(NSString *)phone province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address is_default:(NSString *)is_default WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 我的二维码
- (void)myQRCodeWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;



// ------选择 省/市/县（区）
- (void)chooseCityListRequestForParent_id:(NSString *)parent_id withSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ----- 获取银行卡列表
- (void)bankListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 新增银行卡
- (void)addNewBankWithname:(NSString *)name IDcard:(NSString *)IDcard bank:(NSString *)bank account:(NSString *)account phone:(NSString *)phone Success:(getBackBlock)success failure:(getFailBlock)failure;






#pragma mark - **************** 我的
// ----- 我的
- (void)minedataWithsuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 判断是否可以平台买入
- (void)mineConfigIsShowPingTaiMaiRusuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ---- 我的 - QKT 量子比特
- (void)mineQKTAndLiangZiBiTeWithtype:(NSString *)type success:(getBackBlock)success failure:(getFailBlock)failure;

// --- 转入
- (void)mineZhuanRusuccess:(getBackBlock)success failure:(getFailBlock)failure;

//----- 转出
- (void)mineZhuanChuWithphone:(NSString *)phone qkd:(NSString *)qkd success:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 买入 - 创建订单
- (void)mineMaiRuCreateOrderjye:(NSString *)jye success:(getBackBlock)success failure:(getFailBlock)failure;

//---- 消息列表
- (void)xiaoXiListWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ----- 母币买入
- (void)muBiMaiRuCommitWithqbdzje:(NSString *)qbdzje jtpz:(NSData *)jtpz bzpz:(NSString *)bzpz Success:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 复投
- (void)mineFuTouWithqkd:(NSString *)qkd WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ---- 买入 - 未完成订单 - 未选择收款人
- (void)mineMaiRuUnfinishOrderUnSelectOrderWithSuccess:(getBackBlock)success failure:(getFailBlock)failur;


// ---- 卖出 - 未完成订单 - 未选择收款人
- (void)maichuUnfinshUnselectOrderWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 买入 - 未完成订单 - 未选择收款人 - 取消订单
- (void)mineMaiRuUnselectOrderCancelWithOrderID:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 卖出 - 未完成订单 - 未选择收款人 - 取消订单
- (void)mineMaiChuUnselectOrderCancelWithOrderID:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 买入 - 未完成订单 - 已选择收款人  已选择、确认、完成
- (void)mineMaiRuUnfinishOrderSelectSureFinishOrderWithType:(NSString *)type Success:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 买入 - 未完成 - 已选择 - 付款信息
- (void)mineMaiRuUnfinishSelectPayInfoWithOrderID:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 买入 - 未完成 - 已选择 - 付款 - 提交付款信息
- (void)mineMaiRuUnfinishSelectPayInfoCommitWithorderid:(NSString *)orderid beizhu:(NSString *)beizhu pztp:(NSData *)pztp Success:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 卖出 - 未完成订单 - 已选择收款人  已选择、确认、完成
- (void)mineMaiChuUnfinishOrderSelectSureFinishOrderWithType:(NSString *)type Success:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 卖出 - 确认收款-  付款凭证
- (void)maichuSureOrderShouKuanInfoWithorderid:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;

// ----- 卖出 - 确认收款 - 收款信息 - 收款操作
- (void)mineSureOrderInfoSureShouKuanActionWithOrderid:(NSString *)orderi Success:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 卖出 - 确认订单 - 收款信息
- (void)mineShoukuanInfoWithOrderid:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 买入 - 未完成订单 - 已选择收款人  已选择、确认、完成  - 取消订单
- (void)mineMaiRuUnfinishSelectOrderCanceWithOrderid:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;

// ---- 卖出 - 未完成订单 - 已选择收款人  已选择、确认、完成  - 取消订单
- (void)mineMaiChuUnfinishSelectOrderCanceWithOrderid:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;


// ---- 卖出 - 创建订单
- (void)maichuCreateOrderWithjye:(NSString *)jye Success:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 卖出 - 会员信息
- (void)maichuVIPinfoWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ---- 卖出中心 列表
- (void)mineMaiChuCenterListWithjine:(NSString *)jine Success:(getBackBlock)success failure:(getFailBlock)failure;


// ---- 卖出中心 -- 出售
- (void)mineMaiChuListMaiChuActionWithuid:(NSString *)uid orerID:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;



// ----- 意见反馈
- (void)yiJianFanKuiWithcontent:(NSString *)content fklxr:(NSString *)fklxr fklxfs:(NSString *)fklxfs fkpic:(NSData *)fkpic Success:(getBackBlock)success failure:(getFailBlock)failure;


// ---- 添加银行卡
- (void)addBankListWithzzname:(NSString *)zzname kaihh:(NSString *)kaihh ckr:(NSString *)ckr kahao:(NSString *)kahao sjhm:(NSString *)sjhm zfbzh:(NSString *)zfbzh wxzh:(NSString *)wxzh Success:(getBackBlock)success failure:(getFailBlock)failure;

// ----- 买入中心列表
- (void)mairuCenterListWithjine:(NSString *)jine Success:(getBackBlock)success failure:(getFailBlock)failure;


// --- 买入中心 - 去购买
- (void)mineMaiRuCenterGoBuyWithOrderid:(NSString *)orderid Success:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 系统公告
- (void)systemAdvSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 推广人员
- (void)tuiguangPersonWithtype:(NSString *)type Success:(getBackBlock)success failure:(getFailBlock)failure;






@end
