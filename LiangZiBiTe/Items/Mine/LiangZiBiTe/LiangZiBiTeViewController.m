//
//  LiangZiBiTeViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "LiangZiBiTeViewController.h"
#import "LiangZiBiTeCell.h"
#import "QKDResponse.h"

static NSString *cellID = @"LiangZiBiTeCell";

@interface LiangZiBiTeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LiangZiBiTeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"量子比特"];
    
    [self configTableView];
    
    self.tableView.backgroundColor = LightHexColcor;

}


- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    [self loadData];
    
    
}

- (void)loadData{
    [self.dataSource removeAllObjects];

    [App_HttpsRequestTool mineQKTAndLiangZiBiTeWithtype:@"1" success:^(id responseObject) {
        
        QKDResponse *response = [[QKDResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            
            [self.dataSource addObjectsFromArray:response.data];
            
            
        }else{
            PopInfo(failMsg);
        }
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@""];

        [self.tableView reloadData];

    } failure:^(NSError *error) {
        PopError(netError);
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
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QKDModel *model = self.dataSource[indexPath.row];

    
    LiangZiBiTeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
