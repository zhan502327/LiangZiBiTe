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
    return 590;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuiGuangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    [cell.zhulianButton setTitle:[NSString stringWithFormat:@"主链推广：%@",[App_UserManager zltg]] forState:UIControlStateNormal];
    [cell.celianButton setTitle:[NSString stringWithFormat:@"侧链推广：%@",[App_UserManager cltg]] forState:UIControlStateNormal];

    NSString *zhulianCodeStr = [NSString stringWithFormat:@"http://114.202.245.34/index.php?yqm=%@",[App_UserManager zltg]];
    
    NSString *celianCodeStr = [NSString stringWithFormat:@"http://114.202.245.34/index.php?yqm=%@",[App_UserManager cltg]];

    
    cell.codeImageView.image = [CreateQRCode createQRCodeWithString:zhulianCodeStr withLength:200];
    
    __weak typeof(cell) weakcell = cell;
    
    [cell setZhuTuiBlock:^{
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = zhulianCodeStr;
        
        weakcell.codeImageView.image = [CreateQRCode createQRCodeWithString:zhulianCodeStr withLength:200];
        
        PopSuccess(@"主链推广已复制剪切板");
    }];
    
    [cell setCeTuiBlock:^{
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = celianCodeStr;

        weakcell.codeImageView.image = [CreateQRCode createQRCodeWithString:celianCodeStr withLength:200];

        PopSuccess(@"侧链推广已复制剪切板");

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
