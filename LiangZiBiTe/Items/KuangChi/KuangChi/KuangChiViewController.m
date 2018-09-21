//
//  KuangChiViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "KuangChiViewController.h"
#import "KuangChiResponse.h"

@interface KuangChiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;


@end

@implementation KuangChiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self loadData];
    

    
}


- (void)loadData{
    
    [App_HttpsRequestTool kuangchiCountwithSuccess:^(id responseObject) {
        
        KuangChiResponse *response = [[KuangChiResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {

            self.topLabel.text = response.data.countkc;
            
            self.currentCountLabel.text = [NSString stringWithFormat:@"当前矿池数量：%@",response.data.dqkcs];
            
            
        }else{
            
        }
        
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}

@end
