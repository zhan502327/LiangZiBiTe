//
//  MineViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/8/24.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineCell.h"
#import "LiangZiBiTeViewController.h"
#import "QKTViewController.h"
#import "ZhuanChuViewController.h"

#import "MaiRuUnFinishViewController.h" //------------------删除-------------------
#import "AddBankViewController.h" //------------------删除-------------------

static NSString *headerViewID = @"MineHeaderView";
static NSString *itemcellID = @"MineCell";

#define kGap 1
#define kItemCount 3
#define kItemWidth (Current_Width - (kItemCount+1) *kGap)/kItemCount


@interface MineViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MineViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self configCollectionView];
}

- (void)configCollectionView{
    self.collectionView.backgroundColor = HexColor(0XF5F5F5);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(Current_Width, 300);
    layout.minimumInteritemSpacing = kGap;
    layout.minimumLineSpacing = kGap;//这个控制每个item的间隔
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:itemcellID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:itemcellID];
    
    [self.collectionView registerNib:[UINib nibWithNibName:headerViewID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID];
    

    
}



//-(UICollectionView *)collcetionView{
//
//    if (_collcetionView == nil) {
//        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
//        layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) collectionViewLayout:layOut];
//        collectionView.delegate = self;
//        collectionView.dataSource = self;
//        collectionView.scrollEnabled  = YES;

//        collectionView.backgroundColor = [UIColor clearColor];
//        collectionView.showsHorizontalScrollIndicator = NO;
//        [self.view addSubview:collectionView];
//        _collectionView = collectionView;
//
//    }
//    return _collcetionView;
//}

#pragma mark - collectionView delegate and collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//告知每个块item应该有多大
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kItemWidth , kItemWidth);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemcellID forIndexPath:indexPath];
    cell.titleLabel.text = self.dataSource[indexPath.row][@"title"];
    cell.logImageView.image = UseImage(self.dataSource[indexPath.row][@"image"]);
    return cell;
}

//设置偏移
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//这个控制collectionView距离其父类的上、左、下、右边距
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        MineHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID forIndexPath:indexPath];
        
        [header setScanButtonBlock:^{
            
        }];
        
        
        [header setLeftButtonBlock:^{
            
            QKTViewController *vc = [[QKTViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }];
        
        
        [header setRightButtonBlock:^{
            LiangZiBiTeViewController *vc = [[LiangZiBiTeViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }];
        
        
        return header;
        
    }
    return nil;
    
}


//点击调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%lu组 第%lu个", (long)indexPath.section, (long)indexPath.row);
    
    if (indexPath.row == 1) {//转出
        ZhuanChuViewController *vc = [[ZhuanChuViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 2) {//买入
        MaiRuUnFinishViewController *vc = [[MaiRuUnFinishViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 3) {//卖出
        
        AddBankViewController *vc = [[AddBankViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
}






- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        
        NSArray *titleArray = @[@"转入",@"转出",@"买入",@"卖出",@"推广链接"];
        NSArray *imageArray = @[@"App_Mine_Header_zhuanru",@"App_Mine_Header_zhuanchu",@"App_Mine_Header_mairu",@"App_Mine_Header_maichu",@"App_Mine_Header_tuiguang"];
        for (int i = 0; i<titleArray.count; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:titleArray[i] forKey:@"title"];
            [dic setValue:imageArray[i] forKey:@"image"];
            [array addObject:dic];
        }
        _dataSource = array;
    }
    return _dataSource;
}


































@end
