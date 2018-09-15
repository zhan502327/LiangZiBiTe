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
#import "MaiRuViewController.h"
#import "MineFooterView.h"
#import "MineInfoResponse.h"
#import "ZhuanRuViewController.h"
#import "ConfigPTMRResponse.h"
#import "SettingViewController.h"
#import "TuiGuangViewController.h"
#import "ShiMingResponse.h"
#import "ShiMingViewController.h"


static NSString *headerViewID = @"MineHeaderView";
static NSString *footerViewID = @"MineFooterView";
static NSString *itemcellID = @"MineCell";

#define kGap 1
#define kItemCount 3
#define kItemWidth (Current_Width - (kItemCount+1) *kGap)/kItemCount


@interface MineViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) MineInfoModel *mineModel;

@property (nonatomic, assign) BOOL isHiddenPTMR;
@property (nonatomic, assign) BOOL isHiddenFuTou;



@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self configShiMingApply];
    
}



- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.isHiddenPTMR = YES;
    
    self.isHiddenFuTou = YES;
    
    [self configCollectionView];
    
    [self loadData];
    
    //判断是否显示 平台买入
    [self fonfigIsShowPingTaiMaiRu];
}

#pragma mark -- 判断是否实名认证
- (void)configShiMingApply{
    
    [App_HttpsRequestTool configShiMingRenZhengWithID:[App_UserManager uid] withSuccess:^(id responseObject) {
        
        ShiMingResponse *response = [[ShiMingResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            if ([response.data isEqualToString:@"0"]) {//未实名认证
                
                UIAlertController *loginOutAlert = [UIAlertController alertControllerWithTitle:@"实名认证" message:@"请先上传实名认证信息" preferredStyle:UIAlertControllerStyleAlert];

                [loginOutAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    ShiMingViewController *vc = [[ShiMingViewController alloc] init];
                    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
                    
                }]];
                [self presentViewController:loginOutAlert animated:YES completion:nil];
                
                
                
            }
            
        }else{
            PopInfo(response.msg);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}

- (void)configCollectionView{
    self.collectionView.backgroundColor = HexColor(0XF5F5F5);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(Current_Width, 280);
    layout.footerReferenceSize = CGSizeMake(Current_Width, 120);
    layout.minimumInteritemSpacing = kGap;
    layout.minimumLineSpacing = kGap;//这个控制每个item的间隔
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:itemcellID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:itemcellID];
    
    [self.collectionView registerNib:[UINib nibWithNibName:headerViewID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID];
    
    [self.collectionView registerNib:[UINib nibWithNibName:footerViewID bundle:[NSBundle mainBundle]] 
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewID];

}

- (void)fonfigIsShowPingTaiMaiRu{
    
    [App_HttpsRequestTool mineConfigIsShowPingTaiMaiRusuccess:^(id responseObject) {
        
        ConfigPTMRResponse *response = [[ConfigPTMRResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            if ([response.data isEqualToString:@"0"]) {
                self.isHiddenPTMR = YES;
            }
            
            if ([response.data isEqualToString:@"1"]) {
                self.isHiddenPTMR = NO;
            }
            
            [self.collectionView reloadData];
        }else{
            PopInfo(response.msg);
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}


- (void)loadData{
    
    [App_HttpsRequestTool minedataWithsuccess:^(id responseObject) {
        MineInfoResponse *response = [[MineInfoResponse alloc] initWithDictionary:responseObject error:nil];
        
        if ([response isSuccess]) {
            
            MineInfoModel *model = response.data;
            self.mineModel = model;
            
            if ([model.qkt doubleValue] > 0) {
                self.isHiddenFuTou = NO;
            }else{
                self.isHiddenFuTou = YES;
            }
            
            
            [self.collectionView reloadData];
            
        }else{
            PopInfo(response.msg);
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
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
    
    return CGSizeMake(kItemWidth , kItemWidth - 30);
    
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
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(haderImageViewClicked)];
        [header.headerImageView addGestureRecognizer:tap];

        header.mairuButton.hidden = self.isHiddenPTMR;
        header.fuTouButton.hidden = self.isHiddenFuTou;
        
        
        //星级
        header.starLabel.text = [NSString stringWithFormat:@"x%d",[self.mineModel.xingji intValue]];
        //QKT
        header.leftNumLabel.text = [NSString stringWithFormat:@"%.2f",[self.mineModel.qkt doubleValue]];
        //量子比特
        header.rightNumLabel.text = [NSString stringWithFormat:@"%.2f",[self.mineModel.lzbt doubleValue]];
        //头像
        [header.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.mineModel.pic] placeholderImage:UseImage(@"")];
        //昵称
        header.nameLabel.text = self.mineModel.username;
        //电话
        header.mobileLabel.text = self.mineModel.phone;
        
        
        [header setScanButtonBlock:^{
            
        }];
        
        
        [header setLeftButtonBlock:^{
            
            QKTViewController *vc = [[QKTViewController alloc] init];
            vc.QKD = self.mineModel.qkt;
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }];
        
        
        [header setRightButtonBlock:^{
            LiangZiBiTeViewController *vc = [[LiangZiBiTeViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }];
        
        
        return header;
        
    }
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        MineFooterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewID forIndexPath:indexPath];
        
        [view setLoginoutButtonBlock:^{
           
            UIAlertController *loginOutAlert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确认要退出么？" preferredStyle:UIAlertControllerStyleAlert];
            [loginOutAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }]];
            [loginOutAlert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [App_UserManager loginOut];
            }]];
            [self presentViewController:loginOutAlert animated:YES completion:nil];
            
        }];
        return view;
        
    }
    return nil;
    
}


#pragma mark -- 修改个人信息
- (void)haderImageViewClicked{
    SettingViewController *vc = [[SettingViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}

//点击调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%lu组 第%lu个", (long)indexPath.section, (long)indexPath.row);
    

    
    if (indexPath.row == 0) {//转入
        ZhuanRuViewController *vc = [[ZhuanRuViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    
    if (indexPath.row == 1) {//转出
        ZhuanChuViewController *vc = [[ZhuanChuViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 2) {//买入
        MaiRuViewController *vc = [[MaiRuViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 3) {//卖出
        
//        AddBankViewController *vc = [[AddBankViewController alloc] init];
//        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 4) {//推广链接
        
        TuiGuangViewController *vc = [[TuiGuangViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 5) {//意见反馈
        
        
    }
    
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        
        NSArray *titleArray = @[@"转入",@"转出",@"买入",@"卖出",@"推广链接",@"意见反馈"];
        NSArray *imageArray = @[@"App_Mine_Header_zhuanru",@"App_Mine_Header_zhuanchu",@"App_Mine_Header_mairu",@"App_Mine_Header_maichu",@"App_Mine_Header_tuiguang",@"App_Mine_Header_yijian"];
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
