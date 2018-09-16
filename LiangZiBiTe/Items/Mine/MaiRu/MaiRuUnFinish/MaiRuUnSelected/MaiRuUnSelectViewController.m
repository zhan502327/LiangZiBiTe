//
//  MaiRuUnSelectViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuUnSelectViewController.h"
#import "MaiRuUnSelectedCell.h"
#import "MaiRuUnselectResponse.h"

static NSString *cellID = @"MaiRuUnSelectedCell";

@interface MaiRuUnSelectViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MaiRuUnSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavgiationBarTitle:@"未选择收款人"];
    
    [self configTableView];
    
    [self loadData];
}

- (void)loadData{
    
    [App_HttpsRequestTool mineMaiRuUnfinishOrderUnSelectOrderWithSuccess:^(id responseObject) {
        [self endRefresh];

        MaiRuUnselectResponse *response = [[MaiRuUnselectResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response.data];
            [self.tableView reloadData];
            
        }else{
            
            PopInfo(response.msg);
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@""];
        
    } failure:^(NSError *error) {
        [self endRefresh];
        PopError(netError);
    }];
    
}

- (void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
}
- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
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
    
    MaiRuUnSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = model;
    
    [cell setCancelButtonBlock:^{
       
        [self cancelOrderWithOrderid:model.id];
        
    }];
    return cell;
}

- (void)cancelOrderWithOrderid:(NSString *)orderid{
    
    [App_HttpsRequestTool mineMaiRuUnselectOrderCancelWithOrderID:orderid Success:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"取消订单成功");
            [self loadData];
        }else{
            PopError(@"取消失败");
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
    
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
