//
//  DBProductTwoViewController.m
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "DBProductTwoViewController.h"
#import "DBProductListCell.h"
#import "DBProductListResponse.h"

static NSString *productListCellID = @"DBProductListCell";
@interface DBProductTwoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DBProductTwoViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataAfterActionOfOutSell) name:@"refreshDataAfterActionOfOutSell" object:nil];
    
}

- (void)refreshDataAfterActionOfOutSell{
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView:self.tableView withRefresh:YES];

}

- (void)configTableView:(UITableView *)tableView withRefresh:(BOOL)refresh{
    [self.tableView registerNib:[UINib nibWithNibName:productListCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:productListCellID];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
    
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [self loadData];
}


- (void)loadData{
    [self.tableView.mj_footer resetNoMoreData];
//    [App_HttpsRequestTool markerShopProductListWithStatus:@"0" page:_page pagesize:10 Success:^(id responseObject) {
//        [self endRefreshWithTableView:self.tableView dataSource:self.dataSource];
//        DBProductListResponse *response = [[DBProductListResponse alloc] initWithDictionary:responseObject error:nil];
//        if ([response isSuccess]) {
//            if ([response.result hasMore] == YES) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            }
//            [self.dataSource addObjectsFromArray:response.result.items];
//            [self.tableView reloadData];
//
//        }else{
//
//        }
//
//        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:50 withTitle:@"暂无更多商品"];
//    } failure:^(NSError *error) {
//        [self endRefreshWithTableView:self.tableView dataSource:self.dataSource];
//        [SVProgressHUDManager popTostErrorWithString:netError];
//    }];
    
    [App_HttpsRequestTool mineQKTAndLiangZiBiTeWithtype:@"1" success:^(id responseObject) {
        
        [self endRefresh];
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
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBProductListModel *model = self.dataSource[indexPath.section];
    DBProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:productListCellID];
    cell.model = model;

    
    //删除商品
    [cell setDeleteButtonBlock:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除商品？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteProductWithIndexPath:indexPath];
            
        }];
        
        UIAlertAction *cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sure];
        [alert addAction:cacel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    //上下架商品
    [cell setActionButtonBlock:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否上架商品？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"上架" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self actionProductWithIndexPath:indexPath];
            
        }];
        
        UIAlertAction *cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sure];
        [alert addAction:cacel];
        
        [self presentViewController:alert animated:YES completion:nil];
        
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
    backView.backgroundColor = HexColor(0XF5F5F5);
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

#pragma mark -- 上下架商品
- (void)actionProductWithIndexPath:(NSIndexPath *)index{
    

}

#pragma mark -- 删除商品
- (void)deleteProductWithIndexPath:(NSIndexPath *)index{
    
 
}


-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}


@end
