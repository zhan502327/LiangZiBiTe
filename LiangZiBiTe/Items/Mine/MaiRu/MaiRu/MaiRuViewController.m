//
//  MaiRuViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuViewController.h"
#import "MaiRuProjectButtonCell.h"
#import "SelectMoneyTipsView.h"
#import "MaiRuListViewController.h"
#import "MaiRuUnFinishViewController.h"
#import "MaiRuFooterView.h"


static NSString *maiRuProjectCell = @"MaiRuProjectButtonCell";

@interface MaiRuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) NSString *selectMoneyStr;

@property (nonatomic, strong) NSArray *moneyArray;

@end

@implementation MaiRuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectMoneyStr = self.moneyArray[0];
    
    [self setNavgiationBarTitle:@"买入"];
    
    [self configTableView];
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:maiRuProjectCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:maiRuProjectCell];
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaiRuProjectButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:maiRuProjectCell];
    
    if (indexPath.section == 0) {
        cell.selectView.buttonTitleArray = @[@"创建订单",@"未完成订单",@"确认打款",@"已完成订单",@"买入记录",@"买入中心"];
        //创建订单
        [cell.selectView setOneButtonBlock:^{
           
            
            
        }];
        
        //未完成订单
        [cell.selectView setTwoButtonBlock:^{
            MaiRuUnFinishViewController *vc = [[MaiRuUnFinishViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
            
        }];
        //确认打款
        [cell.selectView setThreeButtonBlock:^{
            
            
            
        }];
        //已完成订单
        [cell.selectView setFourButtonBlock:^{
            
            
            
        }];
        //买入记录
        [cell.selectView setFiveButtonBlock:^{
            MaiRuListViewController *vc = [[MaiRuListViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
            
        }];
        //买入中心
        [cell.selectView setSixButtonBlock:^{
            
            
            
        }];
        
    }else{
        
        cell.selectView.buttonTitleArray = self.moneyArray;
        
        [cell.selectView setOneButtonBlock:^{
            self.selectMoneyStr = self.moneyArray[0];
        }];
        
        [cell.selectView setTwoButtonBlock:^{
            self.selectMoneyStr = self.moneyArray[1];
        }];
        
        [cell.selectView setThreeButtonBlock:^{
            self.selectMoneyStr = self.moneyArray[2];
        }];
        
        [cell.selectView setFourButtonBlock:^{
            self.selectMoneyStr = self.moneyArray[3];
        }];
        
        [cell.selectView setFiveButtonBlock:^{
            self.selectMoneyStr = self.moneyArray[4];
        }];
        
        [cell.selectView setSixButtonBlock:^{
            self.selectMoneyStr = self.moneyArray[5];
        }];
        
    }
    
    
    
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
    if (section == 1) {
        SelectMoneyTipsView *view = [[SelectMoneyTipsView alloc] initWithFrame:CGRectMake(0, 0, Current_Width, 50)];
        return view;
    }else{
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        return backView;
    }
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }else{
        return 0.0000001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        return backView;
    }else{
        MaiRuFooterView *view = [[[NSBundle mainBundle] loadNibNamed:@"MaiRuFooterView" owner:nil options:nil] lastObject];

        [view setCreateOrderBlock:^{
           
            [App_HttpsRequestTool mineMaiRuCreateOrderjye:self.selectMoneyStr success:^(id responseObject) {
                
                BaseResponse * respoinse = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
                if ([respoinse isSuccess]) {
                    
                    PopSuccess(respoinse.msg);
                    
                }else{
                    PopInfo(respoinse.msg);
                }
                
                
            } failure:^(NSError *error) {
                PopError(netError);
            }];
            
        }];
        return view;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.00001;
    }else{
        return 90;
    }
    
}


- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

- (NSArray *)moneyArray{
    if (_moneyArray == nil) {
        NSArray *array = @[@"500",@"1000",@"3000",@"5000",@"10000",@"30000"];
        _moneyArray = array;
    }
    return _moneyArray;
}
@end
