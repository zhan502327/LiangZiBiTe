//
//  MaiChuCenterViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiChuCenterViewController.h"
#import "MaiChuCenterCell.h"
#import "MaiChuCenterResponse.h"

static NSString *cellID = @"MaiChuCenterCell";

@interface MaiChuCenterViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;


@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *selectMoney;

@end

@implementation MaiChuCenterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectMoney = @"500";
    
    [self setNavgiationBarTitle:@"卖出记录"];
    
    [self configTableView];
    
    [self loadData];
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
        [self loadData];
    }];
}

- (void)loadData{
    
    [App_HttpsRequestTool  mineMaiChuCenterListWithjine:self.selectMoney Success:^(id responseObject) {
        
        [self endRefresh];
        
        MaiChuCenterResponse *response = [[MaiChuCenterResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response.data];
            [self.tableView reloadData];
            
        }else{
            
            PopInfo(failMsg);
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@""];
        
        
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
    
    MaiRuUnSelectListModel *model = self.dataSource[indexPath.row];
    
    MaiChuCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = model;
    [cell setSellButtonBlock:^{
        
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



@end
