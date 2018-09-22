//
//  CeLianViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "CeLianViewController.h"
#import "TuiGuangNormallCell.h"
#import "TuiGuangResponse.h"

static NSString *cellid = @"TuiGuangNormallCell";

@interface CeLianViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CeLianViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = LightHexColcor;
    
    [self setNavgiationBarTitle:@"推广侧链"];

    
    [self configTableView];
    
    [self loadData];
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellid bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellid];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
}

- (void)loadData{
    
    [self.dataSource removeAllObjects];
    
    [App_HttpsRequestTool tuiguangPersonWithtype:@"2" Success:^(id responseObject) {
        [self endRefresh];

        TuiGuangResponse *response = [[TuiGuangResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource addObjectsFromArray:response.data.array];
            
            self.titleLabel.text = [NSString stringWithFormat:@"侧链业绩：%@",response.data.count];
            
        }else{
            
        }
        
        [self.tableView reloadData];
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
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuiGuangModel *model = self.dataSource[indexPath.row];
    
    TuiGuangNormallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.model = model;
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
    return 0.0000001;
}


- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}



@end
