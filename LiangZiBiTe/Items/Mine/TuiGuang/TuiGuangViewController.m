//
//  TuiGuangViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "TuiGuangViewController.h"
#import "TuiGuangCell.h"
#import "CreateQRCode.h"

#import <AssetsLibrary/AssetsLibrary.h>

static NSString *cellID = @"TuiGuangCell";

@interface TuiGuangViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TuiGuangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LightHexColcor;

    
    [self setNavgiationBarTitle:@"推广"];
    
    [self configTableView];
    
    
    [self createQRCode];
    
}

- (void)createQRCode{
    
    
}


- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
}




#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 830;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuiGuangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.zhuTuiLabel.text = [App_UserManager zltg];
    cell.ceTuiLabel.text = [App_UserManager cltg];
    
    cell.codeImageView.image = [CreateQRCode createQRCodeWithString:@"www.baidu.con" withLength:200];
    
    __weak typeof(cell) weakcell = cell;
    
    [cell setZhuTuiBlock:^{
       
        weakcell.yaoQingCodeLabel.text = [NSString stringWithFormat:@"邀请码：%@",[App_UserManager zltg]];
        
        [self savePhotoWithView:weakcell.resultView];
        PopSuccess(@"成功保存主链推广码\n请在相册中查看");
        
    }];
    
    [cell setCeTuiBlock:^{
        weakcell.yaoQingCodeLabel.text = [NSString stringWithFormat:@"邀请码：%@",[App_UserManager zltg]];

        [self savePhotoWithView:weakcell.resultView];
        PopSuccess(@"成功保存侧链推广码\n请在相册中查看");

    }];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}


// 保存图片到相册功能，ALAssetsLibraryiOS9.0 以后用photoliabary 替代，
-(void)savePhotoWithView:(UIView *)view
{
    UIImage * image = [self captureImageFromView:view];
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
}
//截图功能
-(UIImage *)captureImageFromView:(UIView *)view
{
    CGRect screenRect = [view bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
