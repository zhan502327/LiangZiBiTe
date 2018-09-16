//
//  MuBiMaiRuViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MuBiMaiRuViewController.h"
#import "MuBiMaiRuResponse.h"
#import "MuBiNextViewController.h"

@interface MuBiMaiRuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;

@end

@implementation MuBiMaiRuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"买入"];

    [self loadData];

}

- (void)loadData{
    
    [App_HttpsRequestTool mineZhuanRusuccess:^(id responseObject) {
        
        MuBiMaiRuResponse *response = [[MuBiMaiRuResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response  isSuccess]) {
            
            [self.logImageView sd_setImageWithURL:[NSURL URLWithString:response.data.qbskm] placeholderImage:UseImage(@"")];
            
        }else{
            PopInfo(response.msg);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}
- (IBAction)nextButtonClicked:(id)sender {
    
    MuBiNextViewController *vc = [[MuBiNextViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
}



@end
