//
//  LiangZiTaoLiViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "LiangZiTaoLiViewController.h"
#import <SDWebImage/UIImage+GIF.h>

@interface LiangZiTaoLiViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end

@implementation LiangZiTaoLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
//    self.webView.backgroundColor = [UIColor redColor];
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"fragment_one_bg" ofType:@"gif"];
//    /*
//     NSData *data = [NSData dataWithContentsOfFile:path];
//     使用loadData:MIMEType:textEncodingName: 则有警告
//     [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//     */
//    NSURL *url = [NSURL URLWithString:path];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fragment_one_bg" ofType:@"gif"];

    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    
    
    self.gifImageView.image = image;
}


@end
