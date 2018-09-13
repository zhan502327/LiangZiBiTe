//
//  BaseResponse.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/12.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "JSONModel/JSONModel.h"

@interface BaseResponse : JSONModel


//"code": 0,
//"msg": "未实名认证",
//"data": 0

/** 错误代码*/
@property (nonatomic, copy) NSString *code;
/** 错误原因（不准 --mark）*/ 
@property (nonatomic, copy) NSString *msg;

/** 返回成功*/
- (BOOL)isSuccess;

@end
