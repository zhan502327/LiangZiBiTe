//
//  MaiRuGoPayPhotoCell.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaiRuGoPayPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *beizhuTextField;
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;

@property (nonatomic, copy) void(^logImageViewBlock)();

@end
