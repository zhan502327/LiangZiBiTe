//
//  TabBarViewController.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/7.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "TabBarViewController.h"
#import "BaseNavViewController.h"
#import "LiangZiTaoLiViewController.h"
#import "JiaoYiSuoViewController.h"
#import "KuangChiViewController.h"
#import "MineViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UITabBar appearance].barTintColor = [UIColor whiteColor];

    self.delegate = self;
 
    LiangZiTaoLiViewController *one = [[LiangZiTaoLiViewController alloc] init];
    [self setRootNavBarViewController:one withBarTitle:@"量子套利" unselectImage:@"App_Tabbar_LiangZiTaoLi_unselected" andSelectImage:@"App_Tabbar_LiangZiTaoLi_selected"];
    
    JiaoYiSuoViewController *two = [[JiaoYiSuoViewController alloc] init];
    [self setRootNavBarViewController:two withBarTitle:@"交易所" unselectImage:@"App_Tabbar_JiaoYiSuo_unselected" andSelectImage:@"App_Tabbar_JiaoYiSuo_selected"];
    
    KuangChiViewController *three = [[KuangChiViewController alloc] init];
    [self setRootNavBarViewController:three withBarTitle:@"矿池" unselectImage:@"App_Tabbar_KuangChi_unselected" andSelectImage:@"App_Tabbar_KuangChi_selected"];
    
    
    MineViewController *four = [[MineViewController alloc] init];
    [self setRootNavBarViewController:four withBarTitle:@"我的" unselectImage:@"App_Tabbar_Mine_unselected" andSelectImage:@"App_Tabbar_Mine_selected"];
    
    
    
    self.selectedIndex = 3;

}

- (void)setRootNavBarViewController:(UIViewController *)childVC withBarTitle:(NSString *)title unselectImage:(NSString *)unselectImage andSelectImage:(NSString *)selectImage  {

    
    BaseNavViewController *childController = [[BaseNavViewController alloc] initWithRootViewController:childVC];
    
    childController.title = title;
    
    // ------全局设置TabBar图标显示原图
    [childController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HexColor(0X333333), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HexColor(0X115BBB), NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    childController.tabBarItem.image = [[UIImage imageNamed:unselectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:childController];
}

#pragma mark - **************** UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (tabBarController.selectedIndex == 1) {

//        if (![App_UserManager isLogin]) {
//            DBLoginViewController *loginVC = [[DBLoginViewController alloc] init];
//            BaseNavViewController *loginNav = [[BaseNavViewController alloc] initWithRootViewController:loginVC];
//            loginNav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
//            [self presentViewController:loginNav animated:YES completion:nil];
//        }
    }
}



@end
