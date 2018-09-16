//
//  QKTViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "QKTViewController.h"
#import "LiangZiBiTeCell.h"
#import "QKDResponse.h"

static NSString *cellID = @"LiangZiBiTeCell";

@interface QKTViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *QKDLabel;

@end

@implementation QKTViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"QKD"];

    [self configTableView];
    
}

- (void)configTableView{
    
    self.QKDLabel.text = [NSString stringWithFormat:@"%.2f",[self.QKD doubleValue]];
    
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    
    [self loadData];
    
}

- (void)loadData{

    [App_HttpsRequestTool mineQKTAndLiangZiBiTeWithtype:@"2" success:^(id responseObject) {
        
        QKDResponse *response = [[QKDResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response.data];
            [self.tableView reloadData];
            
            
        }else{
            PopInfo(response.msg);
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@""];

        
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
