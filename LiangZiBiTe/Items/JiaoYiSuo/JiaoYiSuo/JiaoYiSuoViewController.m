//
//  JiaoYiSuoViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "JiaoYiSuoViewController.h"
#import "JiaoYiSuoHeaderView.h"
#import "JiaoYiSuoLineCell.h"
#import "JiaoYiSuoJiaoYiLiangCell.h"

static NSString *jiaoyiLiangCell = @"JiaoYiSuoJiaoYiLiangCell";
static NSString *jiaoyiLineCell = @"JiaoYiSuoLineCell";


@interface JiaoYiSuoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JiaoYiSuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavgiationBarTitle:@"交易所"];
    
    [self configTableView];
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:jiaoyiLineCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:jiaoyiLineCell];
    [self.tableView registerNib:[UINib nibWithNibName:jiaoyiLiangCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:jiaoyiLiangCell];

    
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else{
        return 250;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        JiaoYiSuoJiaoYiLiangCell *cell = [tableView dequeueReusableCellWithIdentifier:jiaoyiLiangCell];
        return cell;
    }else{
        JiaoYiSuoLineCell *cell = [tableView dequeueReusableCellWithIdentifier:jiaoyiLineCell];
        return cell;
    }
    
    
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
    JiaoYiSuoHeaderView *view = [[JiaoYiSuoHeaderView alloc] initWithFrame:CGRectMake(0, 0, Current_Width, 50)];
    
    if (section == 0) {
        view.contentLabel.text = @"交易量";
    }else{
        view.contentLabel.text = @"量子链条走势图";
    }

    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
    if (_dataSource == nil ) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}


@end
