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
@property (weak, nonatomic) IBOutlet UILabel *beizhuLabel;

@end

@implementation MuBiMaiRuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"母币买入"];

    [self loadData];
    
    self.view.backgroundColor = LightHexColcor;


}

- (void)loadData{
    
    [App_HttpsRequestTool mineZhuanRusuccess:^(id responseObject) {
        
        MuBiMaiRuResponse *response = [[MuBiMaiRuResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response  isSuccess]) {
            
            [self.logImageView sd_setImageWithURL:[NSURL URLWithString:response.data.qbskm] placeholderImage:UseImage(@"")];
            
            self.beizhuLabel.text = response.data.tgmbeiz;
            
        }else{
            PopInfo(failMsg);
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
