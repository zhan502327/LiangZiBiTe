//
//  MaiRuSureOrderViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/19.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuSureOrderViewController.h"
#import "MaiRuSureCell.h"

#import "MaiRuUnselectResponse.h"


static NSString *cellID = @"MaiRuSureCell";

@interface MaiRuSureOrderViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MaiRuSureOrderViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LightHexColcor;

    [self setNavgiationBarTitle:@"确认打款"];

    
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
    [self.dataSource removeAllObjects];

    [App_HttpsRequestTool mineMaiRuUnfinishOrderSelectSureFinishOrderWithType:@"3" Success:^(id responseObject) {
        [self endRefresh];
        
        MaiRuUnselectResponse *response = [[MaiRuUnselectResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource addObjectsFromArray:response.data];
            
        }else{
            
            PopInfo(failMsg);
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@""];
        [self.tableView reloadData];

        
        
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
    
    MaiRuSureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
