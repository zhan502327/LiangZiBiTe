//
//  MaiRuCenterViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuCenterViewController.h"
#import "MaiRuCenterCell.h"
#import "UserInfoResponse.h"
#import "MaiRuCenterResponse.h"

static NSString *cellID = @"MaiRuCenterCell";

@interface MaiRuCenterViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *selectMoney;

@property (nonatomic, strong) MaiRuCenterModel *selectModel;

@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MaiRuCenterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LightHexColcor;

    [self setNavgiationBarTitle:@"买入中心"];
    
    [self configTableView];
    
    
    self.selectMoney = @"500";
    
    [self loadDataWithMoney:self.selectMoney];
}

- (void)setButtonView:(UIView *)buttonView{
    _buttonView = buttonView;
    
    
    
    for (UIButton  *button in buttonView.subviews) {
        
        [button addTarget:self action:@selector(selectMoneyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


- (void)selectMoneyButtonClicked:(UIButton *)button{
    
    
    switch (button.tag) {
        case 1:
            
            self.selectMoney = @"500";
            
            
            break;
        case 2:
            
            self.selectMoney = @"1000";
            break;
        case 3:
            
            self.selectMoney = @"3000";
            break;
        case 4:
            
            self.selectMoney = @"5000";
            break;
            
        case 5:
            
            self.selectMoney = @"10000";
            break;
        case 6:
            
            self.selectMoney = @"30000";
            break;
            
        default:
            break;
    }
    
    [self.tableView.mj_header beginRefreshing];
    
    if (button.isSelected == NO) {
        
        [self configButtonBackGroundColorWithButton:button];
    }
}


- (void)configButtonBackGroundColorWithButton:(UIButton *)button{
    button.selected = !button.isSelected;
    
    if (button.isSelected == YES) {
        button.backgroundColor = HexColor(0X115BBB);
        
        for (UIButton *otherButton in self.buttonView.subviews) {
            if (otherButton.tag == button.tag) {
                
            }else{
                otherButton.selected = !button.isSelected;
                
                otherButton.backgroundColor = [UIColor whiteColor];
            }
            
        }
        
    }
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataWithMoney:self.selectMoney];
    }];
    
}

- (void)loadDataWithMoney:(NSString *)selectMoney{
    
    [self.dataSource removeAllObjects];
    
    [App_HttpsRequestTool mairuCenterListWithjine:selectMoney Success:^(id responseObject) {
        
        [self endRefresh];

        
        
        MaiRuCenterResponse *response = [[MaiRuCenterResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource addObjectsFromArray:response.data];
            
        }else{
            
//            PopInfo(failMsg);
        }
        
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@""];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        PopError(netError);
        [self endRefresh];
    }];
    

    
}

- (void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MaiRuCenterModel *model = self.dataSource[indexPath.row];
    
    MaiRuCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = model;
    
    [cell setBuyButtonBlock:^{
        
        self.selectModel = model;
        
        [self showAlertViewWithType:AlertTypePassword title:@"请输入登录密码"];
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
    return 10;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
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
            
            [self goBuyAction];
            
        }else{
            PopInfo(failMsg);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}


- (void)goBuyAction{
    
    PopLoading(@"买入中");
    
    [App_HttpsRequestTool mineMaiRuCenterGoBuyWithOrderid:self.selectModel.id Success:^(id responseObject) {
        PopDismiss;
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"买入成功");
            
            [self.tableView.mj_header beginRefreshing];
        }else{
            PopInfo(failMsg);
        }
    } failure:^(NSError *error) {
        PopError(netError);
        PopDismiss;
    }];


    
}

@end
