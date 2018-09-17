//
//  MaiRuUnFinishViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/1.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuUnFinishViewController.h"
#import "SGPagingView.h"
#import "MaiRuUnSelectViewController.h"
#import "MaiRuSelectViewController.h"


@interface MaiRuUnFinishViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>


@property (nonatomic, weak) SGPageTitleView *pageTitleView;

@property (nonatomic, weak) SGPageContentScrollView *pageContentView;

@end

@implementation MaiRuUnFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"未完成订单"];
    
    [self pageTitleView];
    [self pageContentView];
    
    
}

- (SGPageTitleView *)pageTitleView{
    if (_pageTitleView == nil) {
        NSArray *titleArray = @[@"未选择收款人",@"已选择收款人"];
        SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
        configure.bottomSeparatorColor = HexColor(0XCCCCCC);
        configure.titleColor = HexColor(0X333333);
        configure.titleSelectedColor = HexColor(0X115BBB);
        configure.indicatorColor = HexColor(0X115BBB);
        configure.indicatorScrollStyle = SGIndicatorScrollStyleHalf;
        
        SGPageTitleView *titleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, Current_Width, 44) delegate:self titleNames:titleArray configure:configure];
        
        
        [self.view addSubview:titleView];
        _pageTitleView = titleView;
    }
    return _pageTitleView;
}

- (SGPageContentScrollView *)pageContentView{
    if (_pageContentView == nil) {
        MaiRuUnSelectViewController *oneVC = [[MaiRuUnSelectViewController alloc] init];
        MaiRuSelectViewController *twoVC = [[MaiRuSelectViewController alloc] init];
        
        
        NSArray *childArr = @[oneVC,twoVC];
        
        SGPageContentScrollView *contentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageTitleView.frame), Current_Width, Current_Height - CGRectGetMaxY(self.pageTitleView.frame) - TabBar_Height) parentVC:self childVCs:childArr];
        contentView.delegatePageContentScrollView = self;
        
        [self.view addSubview:contentView];
        _pageContentView = contentView;
    }
    return _pageContentView;
}

//滚动内容视图的代理方法
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    
}

//滚动标题视图的代理方法
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex{
    [self.pageContentView setPageContentScrollViewCurrentIndex:selectedIndex];
}



@end
