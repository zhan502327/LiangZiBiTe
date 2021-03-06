//
//  ZZYPhotoHelper.m
//  OC_FunctionDemo
//
//  Created by 周智勇 on 16/9/9.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "ZZYPhotoHelper.h"

@interface ZZYPhotoDelegateHelper: NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) ZZYPhotoHelperBlock selectImageBlock;

@end

@interface ZZYPhotoHelper ()
@property (nonatomic, strong) ZZYPhotoDelegateHelper *helper;

@end

static ZZYPhotoHelper *picker = nil;
@implementation ZZYPhotoHelper

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)){//避免滚动视图顶部出现20的空白以及push或者pop的时候页面有一个上移或者下移的异常动画的问题
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

+ (instancetype)shareHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[ZZYPhotoHelper alloc] init];
        
   
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
                  
        //主色调
        picker.navigationBar.barTintColor = [UIColor clearColor];
        //
        
        picker.navigationItem.title = @"";
        
        picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HexColor(0XFFFFFF),NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:16]};
        
        
    });
    return picker;
}

- (void)showImageViewSelcteWithResultBlock:(ZZYPhotoHelperBlock)selectImageBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * library = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self creatWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary block:selectImageBlock];
    }];
    UIAlertAction * carmare = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self creatWithSourceType:UIImagePickerControllerSourceTypeCamera block:selectImageBlock];
        }else{
//            [MBProgressHUD showError:@"相机功能暂不能使用"];
        }
    }];
    [alertController addAction:canleAction];
    [alertController addAction:library];
    [alertController addAction:carmare];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
  


- (void)creatWithSourceType:(UIImagePickerControllerSourceType)sourceType block:selectImageBlock{
    picker.helper                  = [[ZZYPhotoDelegateHelper alloc] init];
    picker.delegate                = picker.helper;
    picker.sourceType              = sourceType;
    picker.allowsEditing = YES;//默认是可以修改的
    
    picker.helper.selectImageBlock = selectImageBlock;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

@end


@implementation ZZYPhotoDelegateHelper

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *theImage = nil;
    // 判断，图片是否允许修改。默认是可以的
    if ([picker allowsEditing]){
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    if (_selectImageBlock) {
        _selectImageBlock(theImage);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
