//
//  MaiChuViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiChuViewController.h"
#import "MaiRuProjectButtonCell.h"
#import "SelectMoneyTipsView.h"
#import "MaiRuFooterView.h"
#import "UserInfoResponse.h"
#import "MaiChuBankTableViewCell.h"
#import "MaiChuVipInfoResponse.h"
#import "MiaChuOrderViewController.h"
#import "MaiChuSureOrderViewController.h"
#import "MaiChuFinishViewController.h"
#import "MaiChuListViewController.h"
#import "MaiChuCenterViewController.h"
#import "AddBankViewController.h"


static NSString *maiRuProjectCell = @"MaiRuProjectButtonCell";
static NSString *bankCell = @"MaiChuBankTableViewCell";

@interface MaiChuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *selectMoneyStr;
@property (nonatomic, strong) NSArray *moneyArray;

@property (nonatomic, strong) MaiChuVipInfoModel *bankModel;

@end

@implementation MaiChuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LightHexColcor;

    self.selectMoneyStr = self.moneyArray[0];
    
    [self setNavgiationBarTitle:@"卖出"];
    
    [self configTableView];
    
    [self loadData];
}

- (void)loadData{
    
    [App_HttpsRequestTool maichuVIPinfoWithSuccess:^(id responseObject) {
        MaiChuVipInfoResponse *response = [[MaiChuVipInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            MaiChuVipInfoModel *bankModel = response.data;
            self.bankModel = bankModel;
            
            
        }else{
            
            self.bankModel = nil;
            
        }
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:maiRuProjectCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:maiRuProjectCell];
    [self.tableView registerNib:[UINib nibWithNibName:bankCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bankCell];

}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 150;
    }else{
        return 160;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        MaiRuProjectButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:maiRuProjectCell];

        
        cell.selectView.buttonTitleArray = @[@"创建订单",@"未完成订单",@"确认打款",@"已完成订单",@"卖出记录",@"卖出中心"];
        //创建订单
        [cell.selectView setOneButtonBlock:^{
            
            
            
        }];
        
        //未完成订单
        [cell.selectView setTwoButtonBlock:^{
            MiaChuOrderViewController *vc = [[MiaChuOrderViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
            
        }];
        //确认打款
        [cell.selectView setThreeButtonBlock:^{
            
            MaiChuSureOrderViewController *vc = [[MaiChuSureOrderViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
        }];
        //已完成订单
        [cell.selectView setFourButtonBlock:^{
            
            MaiChuFinishViewController *vc = [[MaiChuFinishViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
        }];
        //卖出记录
        [cell.selectView setFiveButtonBlock:^{
            MaiChuListViewController *vc = [[MaiChuListViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
            
        }];
        //卖出中心
        [cell.selectView setSixButtonBlock:^{
            
            MaiChuCenterViewController *vc = [[MaiChuCenterViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
        }];
        
        return cell;

        
    }else if (indexPath.section == 1){
        
        MaiChuVipInfoModel *model = self.bankModel;
        MaiChuBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bankCell];
        cell.model = model;
        return cell;
        
        
    }
    
    
    else{
        
        MaiRuProjectButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:maiRuProjectCell];

        
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
        return cell;

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    if (indexPath.section == 1) {
        
        if (self.bankModel == nil) {
            
            AddBankViewController *vc = [[AddBankViewController alloc] init];
            [vc setRefreshDataAfterBankInfoBlock:^{
               
                [self loadData];
            }];
            
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
        }
    }
    
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        SelectMoneyTipsView *view = [[SelectMoneyTipsView alloc] initWithFrame:CGRectMake(0, 0, Current_Width, 50)];
        view.tipsLabel.text = @"选择卖出金额";
        return view;
    }else{
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        return backView;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 50;
    }else{
        return 0.0000001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        MaiRuFooterView *view = [[[NSBundle mainBundle] loadNibNamed:@"MaiRuFooterView" owner:nil options:nil] lastObject];
        [view setCreateOrderBlock:^{
            [self showAlertViewWithType:AlertTypePassword title:@"请输入登录密码"];
        }];
        return view;
    }else{
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        return backView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 90;
    }else{
        return 0.000001;
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



#pragma mark -- 显示弹框
- (void)showAlertViewWithType:(AlertType)type title:(NSString *)title{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        if (userNameTextField.text.length == 0) {
            return ;
        }
        
        switch (type) {
            case AlertTypePassword:
                
                [self configPasswordWithText:userNameTextField.text];
                
                
                break;
                
            case AlertTypeNum:
                
                //                [self configFuTouNumWithNum:userNameTextField.text];
                
                
                break;
                
                
                
                
            default:
                break;
        }
        
        
        
    }]];
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
        
        textField.placeholder = title;
        switch (type) {
            case AlertTypePassword:
                
                textField.secureTextEntry=YES;
                
                break;
                
                
            case AlertTypeNum:
                
                textField.keyboardType = UIKeyboardTypeNumberPad;
                
                break;
            default:
                break;
        }
        
        
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];

}


#pragma mark -- 验证支付密码
- (void)configPasswordWithText:(NSString *)text{
    [App_HttpsRequestTool loginLoginRequestMobile:[App_UserManager phone] password:text withSuccess:^(id responseObject) {
        
        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self createOrder];
            
        }else{
            PopInfo(failMsg);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}


- (void)createOrder{
    
    PopLoading(@"卖出中");
    
    [App_HttpsRequestTool maichuCreateOrderWithjye:self.selectMoneyStr Success:^(id responseObject) {
        PopDismiss;
        BaseResponse * respoinse = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([respoinse isSuccess]) {
            
            NSString *str = [NSString stringWithFormat:@"成功卖出%@",self.selectMoneyStr];
            PopSuccess(str);
            
        }else{
            PopInfo(failMsg);
        }
    } failure:^(NSError *error) {
        PopError(netError);
        PopDismiss;

    }];
    
 
}

@end
