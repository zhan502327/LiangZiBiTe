//
//  SystemAdvModel.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SystemAdvModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *text;
@property (nonatomic, copy) NSString <Optional> *time;

//"id": 1,
//"text": "滚动公告的内容",
//"time": "更新发布时间"

@end
