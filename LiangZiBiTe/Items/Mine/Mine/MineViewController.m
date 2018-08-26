//
//  MineViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/8/24.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self getHistorycharData];
    
}


//发送请求获取曲线数据
- (void)getHistorycharData
{
    

    //组装参数
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    params[@"a_id"] = @"167";
    //说明是哪条曲线
    params[@"num"] = @"1,2,3,4,5,6";
    params[@"time"] = @"20180202";
    /**h小时 d天 w周 m月  hy半年 y年*/
    //params[@"time"] = @"20171113";
    params[@"model"] = @"avg";
    //    type=hy&model=avg&num=1&time=201702&a_id=58




    /**h小时 d天 w周 m月  hy半年 y年*/
//    if ([self.weekStr isEqualToString:@"1小时"]){
//        params[@"type"] = @"h";
//    } else if ([self.weekStr isEqualToString:@"1天"]){
//        params[@"type"] = @"d";
//    } else  if ([self.weekStr isEqualToString:@"1周"]) {
//        params[@"type"] = @"w";
//    } else if ([self.weekStr isEqualToString:@"1个月"]){
//        params[@"type"] = @"m";
//    }else  if ([self.weekStr isEqualToString:@"3个月"]){
//        params[@"type"] = @"q";
//    }else  if ([self.weekStr isEqualToString:@"6个月"]){
//        params[@"type"] = @"hy";
//    }else  if ([self.weekStr isEqualToString:@"1年"]){
//        params[@"type"] = @"y";
//    }
    
    params[@"type"] = @"d";


    //请求数据
    [App_HttpsRequestTool textWithDic:params withSuccess:^(id responseObject) {
        
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];

}


@end
