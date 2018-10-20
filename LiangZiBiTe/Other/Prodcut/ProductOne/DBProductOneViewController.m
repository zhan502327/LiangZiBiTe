//
//  DBProductOneViewController.m
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "DBProductOneViewController.h"
#import "DBProductListCell.h"
#import "DBProductListResponse.h"

static NSString *productListCellID = @"DBProductListCell";

@interface DBProductOneViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DBProductOneViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataAfterActionOfOnSell) name:@"refreshDataAfterActionOfOnSell" object:nil];
    
}

- (void)refreshDataAfterActionOfOnSell{
    
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView:self.tableView withRefresh:YES];
    
    [self loadData];
    
}

- (void)configTableView:(UITableView *)tableView withRefresh:(BOOL)refresh{
    
    
    [self.tableView registerNib:[UINib nibWithNibName:productListCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:productListCellID];
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];

}

- (void)loadData{
    [self.tableView.mj_footer resetNoMoreData];
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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否下架商品？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"下架" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
    DBProductListModel *model = self.dataSource[index.section];
    
//    [App_HttpsRequestTool productOnSellerOrNotWithproduct_sn:model.product_sn Success:^(id responseObject) {
//        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
//        if ([response isSuccess]) {
//
//            [self.dataSource removeObjectAtIndex:index.section];
//            [self.tableView reloadData];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshDataAfterActionOfOutSell" object:nil userInfo:nil];
//        }
//        [SVProgressHUDManager popTostSuccessWithString:response.reason];
//
//    } failure:^(NSError *error) {
//        [SVProgressHUDManager popTostErrorWithString:netError];
//
//    }];
}

#pragma mark -- 删除商品
- (void)deleteProductWithIndexPath:(NSIndexPath *)index{
    DBProductListModel *model = self.dataSource[index.section];

//    [App_HttpsRequestTool deleteProductWithproduct_sn:model.product_sn Success:^(id responseObject) {
//        
//        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
//        if ([response isSuccess]) {
//            [self.dataSource removeObjectAtIndex:index.section];
//            [self.tableView reloadData];
//        }
//        [SVProgressHUDManager popTostSuccessWithString:response.reason];
//
//    } failure:^(NSError *error) {
//        [SVProgressHUDManager popTostErrorWithString:netError];
//    }];

}


-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

@end
