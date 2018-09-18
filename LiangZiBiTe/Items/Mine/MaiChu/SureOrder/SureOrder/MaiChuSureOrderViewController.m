//
//  MaiChuSureOrderViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiChuSureOrderViewController.h"
#import "MaiChuSureOrderCell.h"
#import "MaiRuUnselectResponse.h"

static NSString *cellID = @"MaiChuSureOrderCell";


@interface MaiChuSureOrderViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MaiChuSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"确认订单"];
    
    [self configTableView];
    
    [self loadData];
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

- (void)loadData{
    
    [App_HttpsRequestTool mineMaiChuUnfinishOrderSelectSureFinishOrderWithType:@"3" Success:^(id responseObject) {
        [self endRefresh];
        
        MaiRuUnselectResponse *response = [[MaiRuUnselectResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response.data];
            [self.tableView reloadData];
            
        }else{
            
            PopInfo(failMsg);
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
    
    MaiChuSureOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = model;
    
    [cell setShouKuanInfoButtonBlock:^{
        
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
