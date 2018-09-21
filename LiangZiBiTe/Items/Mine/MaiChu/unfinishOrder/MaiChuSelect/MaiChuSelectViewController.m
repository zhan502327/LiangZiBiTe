//
//  MaiChuSelectViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiChuSelectViewController.h"
#import "MaiChuSelectCell.h"
#import "MaiRuUnselectResponse.h"


static NSString *cellID = @"MaiChuSelectCell";

@interface MaiChuSelectViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MaiChuSelectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = LightHexColcor;

    
    [self setNavgiationBarTitle:@"已选择收款人"];
    
    [self configTableView];
    
    [self loadData];
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)loadData{
    [self.dataSource removeAllObjects];

    [App_HttpsRequestTool mineMaiChuUnfinishOrderSelectSureFinishOrderWithType:@"2" Success:^(id responseObject) {
        [self endRefresh];
        
        MaiRuUnselectResponse *response = [[MaiRuUnselectResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource addObjectsFromArray:response.data];
            
        }else{
            
//            PopInfo(failMsg);
        }
        [self.tableView reloadData];

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
    
    MaiChuSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = model;
    
    [cell setCancelButtonBlock:^{
        [self cancelOrder:model.id];
    }];
    
    return cell;
}

- (void)cancelOrder:(NSString *)orderid{
    
    
    [App_HttpsRequestTool mineMaiChuUnfinishSelectOrderCanceWithOrderid:orderid Success:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"取消成功");
            [self loadData];
            
        }else{
            PopInfo(failMsg);
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
