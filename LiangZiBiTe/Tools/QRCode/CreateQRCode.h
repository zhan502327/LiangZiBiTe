//
//  CreateQRCode.h
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateQRCode : NSObject

+ (UIImage *)createQRCodeWithString:(NSString *)string withLength:(CGFloat)length;

/**
 2  *  根据CIImage生成指定大小的UIImage
 3  *
 4  *  @param image CIImage
 5  *  @param length  图片宽度
 6  */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withLength:(CGFloat)length;

@end
