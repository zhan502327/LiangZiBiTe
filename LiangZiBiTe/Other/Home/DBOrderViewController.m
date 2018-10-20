//
//  DBOrderViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/10/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "DBOrderViewController.h"
#import "DBOrderListCell.h"
#import "MarketOrderResponse.h"
#import "MarketOrderProductModel.h"
//#import "DBOrderHeader.h"


static NSString *orderListCellID = @"DBOrderListCell";


@interface DBOrderViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;



@end

@implementation DBOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"订单列表"];
    [self configTableView:self.tableView withRefresh:YES];
    
    [self loadData];
    
}



- (void)refreshDataAfterReceiveNotification:(NSNotification *)notification{
    [self.tableView.mj_header beginRefreshing];
    
    
}


- (void)configTableView:(UITableView *)tableView withRefresh:(BOOL)refresh{
    
    
    [self.tableView registerNib:[UINib nibWithNibName:orderListCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:orderListCellID];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
    }];
}



- (void)loadData{
    [self.tableView.mj_footer resetNoMoreData];
    
    
    
    [App_HttpsRequestTool mineQKTAndLiangZiBiTeWithtype:@"2" success:^(id responseObject) {
        
        [self endRefresh];
        [self.tableView reloadData];
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@"暂无订单"];
        
        
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
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MarketOrderModel *model = self.dataSource[section];
    NSArray *array = model.makprod;
    return array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketOrderModel *ordermodel = self.dataSource[indexPath.section];
    NSArray *array = ordermodel.makprod;
    
    DBOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:orderListCellID];
    MarketOrderProductModel *productmodel = array[indexPath.row];
    cell.model = productmodel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
//    DBOrderDetailViewController *vc = [[DBOrderDetailViewController alloc] init];
//    MarketOrderModel *ordermodel = self.dataSource[indexPath.section];
//    vc.orderModel = ordermodel;
//    [self.rt_navigationController pushViewController:vc animated:YES];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    MarketOrderModel *ordermodel = self.dataSource[section];
//
//    DBOrderHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"DBOrderHeader" owner:nil options:nil] lastObject];
//    header.orderCodeLabel.text = [NSString stringWithFormat:@"订单号： %@",ordermodel.order_sn];
//
//    if ([ordermodel.status isEqualToString:@"0"]) {
//        header.orderStatusLabel.text = @"待付款";
//    }else if ([ordermodel.status isEqualToString:@"1"]){
//        header.orderStatusLabel.text = @"待发货";
//    }else if ([ordermodel.status isEqualToString:@"2"]){
//        header.orderStatusLabel.text = @"待收货";
//    }else if ([ordermodel.status isEqualToString:@"3"]){
//        if ([ordermodel.evaluateStatus isEqualToString:@"0"]) {
//            header.orderStatusLabel.text = @"收货未评价";
//        }else{
//            header.orderStatusLabel.text = @"收货已评价";
//        }
//    }else if ([ordermodel.status isEqualToString:@"4"]){
//        header.orderStatusLabel.text = @"交易关闭";
//    }
//    return header;
    
    
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    MarketOrderModel *ordermodel = self.dataSource[section];
//
//    DBOrderFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"DBOrderFooter" owner:nil options:nil] lastObject];
//    [footer setSecondButtonBlock:^{
//
//        DBOrderDetailViewController *vc = [[DBOrderDetailViewController alloc] init];
//        vc.orderModel = ordermodel;
//        [self.rt_navigationController pushViewController:vc animated:YES];
//
//    }];
//
//    [footer setContractBuyerBlock:^{
//
//        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",ordermodel.consignee_mobile];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//
//    }];
//
//    return footer;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    return 50;
    return 0.0001;
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}


@end
