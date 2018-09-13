//
//  ZhuanRuViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ZhuanRuViewController.h"
#import "ZhuanRuResponse.h"

@interface ZhuanRuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;

@end

@implementation ZhuanRuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"转入"];
    
    [self loadData];

}

- (void)loadData{
    
    [App_HttpsRequestTool mineZhuanRusuccess:^(id responseObject) {
        
        ZhuanRuResponse *response = [[ZhuanRuResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response  isSuccess]) {
            
            [self.logImageView sd_setImageWithURL:[NSURL URLWithString:response.data] placeholderImage:UseImage(@"")];
            
        }else{
            PopInfo(response.msg);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}
@end
