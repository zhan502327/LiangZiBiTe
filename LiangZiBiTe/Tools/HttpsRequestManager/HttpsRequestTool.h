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


#pragma mark - **************** 首页
// ----- 首页
- (void)appShouyewithSuccess:(getBackBlock)success failure:(getFailBlock)failure;
















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







#pragma mark - **************** 商城
// ------ 商城首页-banner
- (void)marketBannerRequestWithType:(NSString *)type WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

//商品列表
- (void)marketProductListWithpage:(int)page pagesize:(int)pagesize category:(NSString *)category WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 商城首页最新列表和热门列表
- (void)marketHotListAndNewListRequestWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 商品详情
- (void)marketDetailWithgoods_id:(NSString *)goods_id tWithSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ----- 积分兑换
- (void)jifenDuihuanWithgood_id:(NSString *)good_id WithSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ------ 订单结算
- (void)orderSureresult:(NSString *)result Success:(getBackBlock)success failure:(getFailBlock)failure;

// ----- 立即购买 /order/add
- (void)goBuyNowWithids:(NSString *)ids buynum:(NSString *)buynum address_id:(NSString *)address_id attrvalueid:(NSString *)attrvalueid paytype:(NSString *)paytype Success:(getBackBlock)success failure:(getFailBlock)failure;

// ------ 点击规格 获取价格
- (void)clickProductCategoryGetPriceWithgoods_id:(NSString *)goods_id attrvalue_id:(NSString *)attrvalue_id Success:(getBackBlock)success failure:(getFailBlock)failure;
// ------添加购物车
- (void)marketShoppingCarAddProductRequestDataForProduct_id:(NSString *)product_id buynum:(NSString *)buynum price:(NSString *)price goods_attr_store_id:(NSString *)goods_attr_store_id attrvalue_id:(NSString *)attrvalue_id remark:(NSString *)remark withSuccess:(getBackBlock)success failure:(getFailBlock)failure;

// ----- 购物车列表
- (void)carListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure;




// ------改变商品数量
- (void)marketChangeProductNumRequestDataForProduct_id:(NSString *)product_id buyNum:(NSString *)buyNum withSuccess:(getBackBlock)success failure:(getFailBlock)failure;


// ------删除购物车商品
- (void)marketShoppingCarListDeleteProductWithproduct_sn:(NSString *)product_sn withSuccess:(getBackBlock)success failure:(getFailBlock)failure;


















#pragma mark - **************** 福利
// ------ 福利首页
- (void)welfareListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure;






#pragma mark - **************** 推广
// ------  推广首页
- (void)extentionwithSuccess:(getBackBlock)success failure:(getFailBlock)failure;

@end
