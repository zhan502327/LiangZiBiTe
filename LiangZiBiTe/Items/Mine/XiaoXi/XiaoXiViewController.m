//
//  XiaoXiViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "XiaoXiResponse.h"
#import "XiaoXiListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DBDataBaseManager.h"

static NSString *cellID = @"XiaoXiListCell";



@interface XiaoXiViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation XiaoXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LightHexColcor;

    
    [self setNavgiationBarTitle:@"消息"];
    
    [self configXiaoXiList];
    
    [self configTabelView];
    
}

- (void)configTabelView{
    
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
}



#pragma mark -- 判断消息列表
- (void)configXiaoXiList{
    
    [App_HttpsRequestTool xiaoXiListWithSuccess:^(id responseObject) {
        
        XiaoXiResponse *response = [[XiaoXiResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource removeAllObjects];
            
            //请求到的数据
            NSArray *dataArray = response.data;
            
            //数据源
            [self.dataSource addObjectsFromArray:dataArray];
            
            //获得模型数据
            [self.tableView reloadData];
            
            
            //点击cell 更新数据库 isLooked 为已读
            
            for (XiaoXiModel *model in dataArray) {
                
                [[DBDataBaseManager shareDataBaseManager] updateNotificationModel:model tableName:kNotificationOne WithIsLooked:@"1"];
                
            }
            
        }else{
            PopInfo(failMsg);
            
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@"暂无消息"];
        
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
    XiaoXiModel *model = self.dataSource[indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:cellID configuration:^(XiaoXiListCell * cell) {
        
        cell.model = model;
        cell.contentLabel.preferredMaxLayoutWidth = Current_Width - 20;
        
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiaoXiModel *model = self.dataSource[indexPath.row];
    
    XiaoXiListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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


-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}




@end
