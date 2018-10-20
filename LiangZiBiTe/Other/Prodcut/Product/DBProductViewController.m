//
//  DBProductViewController.m
//  JianZuLianSeller
//
//  Created by zhang shuai on 2018/2/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "DBProductViewController.h"
#import "DBProductOneViewController.h"
#import "DBProductTwoViewController.h"
#import "SGPageTitleViewConfigure.h"
#import "SGPageTitleView.h"
#import "SGPageContentCollectionView.h"
#import "SGPageContentScrollView.h"
#import "DBSellerIndentificationResponse.h"

@interface DBProductViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) SGPageContentScrollView *pageContentView;
@property (nonatomic, weak) SGPageTitleView *pageTitleView;

@end

@implementation DBProductViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"商品"];
    
    [self pageTitleView];
    [self pageContentView];
    
}


- (void)configTableView{
    [self.tableView setEmptyViewWithArray:self.dataSource withMargin:50 withTitle:@"认证成为商家后才能开店发布商品"];
}





#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}







- (SGPageTitleView *)pageTitleView{
    if (_pageTitleView == nil) {
        NSArray *titleArray = @[@"销售中",@"已下架"];
        SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
        configure.bottomSeparatorColor = HexColor(0XCCCCCC);
        configure.titleSelectedColor = HexColor(0X49a65a);
        configure.indicatorColor = HexColor(0X49a65a);
        configure.indicatorScrollStyle = SGIndicatorScrollStyleDefault;
        
        SGPageTitleView *titleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, Current_Width, 44) delegate:self titleNames:titleArray configure:configure];
        //        titleView.isNeedBounces = NO;
        //        titleView.isTitleGradientEffect = NO;
        
        
        [self.view addSubview:titleView];
        _pageTitleView = titleView;
    }
    return _pageTitleView;
}




- (SGPageContentScrollView *)pageContentView{
    if (_pageContentView == nil) {
        DBProductOneViewController *oneVC = [[DBProductOneViewController alloc] init];
        
        DBProductTwoViewController *twoVC = [[DBProductTwoViewController alloc] init];
        
        NSArray *childArr = @[oneVC,twoVC];
        
        SGPageContentScrollView *contentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageTitleView.frame), Current_Width, Current_Height - CGRectGetMaxY(self.pageTitleView.frame) - TabBar_Height) parentVC:self childVCs:childArr];
        contentView.delegatePageContentScrollView = self;
        
        [self.view addSubview:contentView];
        _pageContentView = contentView;
    }
    return _pageContentView;
}


//- (SGPageContentScrollView *)pageContentView{
//    if (_pageContentView == nil) {
//        ProjectResourceMinePubLishVC *oneVC = [[ProjectResourceMinePubLishVC alloc] init];
//        ProjectResourceMineGuanZhuVC *twoVC = [[ProjectResourceMineGuanZhuVC alloc] init];
//
//        NSArray *childArr = @[oneVC, twoVC];
//
//        SGPageContentScrollView *contentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame), Current_Width - 20, Current_Height - CGRectGetMaxY(self.topView.frame) - NavBar_Height) parentVC:self childVCs:childArr];
//        contentView.delegatePageContentScrollView = self;
//
//        contentView.backgroundColor = HexColor(0XF5F5F5);
//        contentView.layer.masksToBounds = YES;
//        contentView.layer.cornerRadius = 5;
//
//        [self.view addSubview:contentView];
//        _pageContentView = contentView;
//    }
//    return _pageContentView;
//}


//滚动内容视图的代理方法
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    
    
    
    
    
}

//滚动标题视图的代理方法
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex{
    [self.pageContentView setPageContentScrollViewCurrentIndex:selectedIndex];
    
    
    
    
    
}


//#pragma mark - **************** 懒加载
//- (CQScrollMenuView *)scrollMenuView {
//    if (!_scrollMenuView) {
//        CQScrollMenuView *menuView = [[CQScrollMenuView alloc]initWithFrame:CGRectMake(0, 0, Current_Width, 39.5)];
//        menuView.menuButtonClickedDelegate = self;
////        menuView.delegate = self;
//        menuView.titleArray = @[@"已上架",@"未上架"];
//        menuView.backgroundColor = [UIColor whiteColor];
//        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, Current_Width, 0.5)];
//        lineLabel.backgroundColor = HexColor(0XCCCCCC);
//        [self.view addSubview:lineLabel];
//        [self.view addSubview:menuView];
//        _scrollMenuView = menuView;
//    }
//    return _scrollMenuView;
//}
//
//#pragma mark - **************** CQScrollMenuViewDelegate
//- (void)scrollMenuView:(CQScrollMenuView *)scrollMenuView clickedButtonAtIndex:(NSInteger)index {
//    if (index == 0) {
//        NSLog(@"已上架");
//    }else {
//        NSLog(@"未上架");
//
//    }
//}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}
@end
