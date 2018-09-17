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
#import "UserInfoResponse.h"


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
        
        view.tipsLabel.text = @"选择买入金额";
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
           
            
            [self showAlertViewWithType:AlertTypePassword title:@"请输入登录密码"];

            
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
    [App_HttpsRequestTool mineMaiRuCreateOrderjye:self.selectMoneyStr success:^(id responseObject) {
        
        BaseResponse * respoinse = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([respoinse isSuccess]) {
            
            NSString *str = [NSString stringWithFormat:@"成功买入%@",self.selectMoneyStr];
            PopSuccess(str);
            
        }else{
            PopInfo(failMsg);
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}

@end
