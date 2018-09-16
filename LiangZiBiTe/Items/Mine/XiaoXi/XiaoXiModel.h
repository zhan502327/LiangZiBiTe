//
//  XiaoXiModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface XiaoXiModel : JSONModel


@property (nonatomic, copy) NSString <Optional> *addtime;
@property (nonatomic, copy) NSString <Optional> *content;
@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *state;
@property (nonatomic, copy) NSString <Optional> *title;
@property (nonatomic, copy) NSString <Optional> *uid;

@property (nonatomic, copy) NSString <Optional> *isLooked;


//title    int    消息标题
//content    int    消息内容
//addtime    int    时间
//state    int    0 未读 1已读

@end
