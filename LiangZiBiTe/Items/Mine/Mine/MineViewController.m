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
#import "XiaoXiViewController.h"
#import "XiaoXiResponse.h"
#import "DBDataBaseManager.h"
#import "MuBiMaiRuViewController.h"
#import "UserInfoResponse.h"
#import "MaiChuViewController.h"
#import "YiJianFanKuiViewController.h"

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

@property (nonatomic, assign) BOOL isHiddenXiaoXiRedTips;


@property (nonatomic, strong) NSMutableArray *xiaoxiDataSource;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //判断实名认证
    [self configShiMingApply];
    
    //判断消息列表
    [self configXiaoXiList];
    
    //加载数据
    [self loadData];
}




- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    self.isHiddenPTMR = YES;
    
    self.isHiddenFuTou = YES;
    
    self.isHiddenXiaoXiRedTips = YES;
    
    [self configCollectionView];
    
    
    //判断是否显示 平台买入
    [self fonfigIsShowPingTaiMaiRu];
}
#pragma mark -- 判断消息列表
- (void)configXiaoXiList{
    [self.xiaoxiDataSource removeAllObjects];
    
    [App_HttpsRequestTool xiaoXiListWithSuccess:^(id responseObject) {
        
        XiaoXiResponse *response = [[XiaoXiResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            
            //请求到的数据
            NSArray *dataArray = response.data;
            
            //数据源
            [self.xiaoxiDataSource addObjectsFromArray:dataArray];
            
            //            //获得模型数据
            //            [self.tableView reloadData];
            
            
            //写入数据库
            if (dataArray.count > 0) {
                for (XiaoXiModel *model in dataArray) {
                    [[DBDataBaseManager shareDataBaseManager] insertNotificationModel:model tableName:kNotificationOne];
                }
            }
            //获取未读数据 数组
            NSMutableArray *notLookedArray = [NSMutableArray arrayWithCapacity:0];
            
            for (int i = 0; i<dataArray.count; i++) {
                
                XiaoXiModel *model = dataArray[i];
                
                XiaoXiModel *resultModel = [[DBDataBaseManager shareDataBaseManager] queryIsLookedOrNotWithTableName:kNotificationOne model:model];
                if ([resultModel.isLooked isEqualToString:@"0"]) {
                    [notLookedArray addObject:model];
                }
            }
            
            //            //查询 isLooked 数据
            //            NSArray *isLookedArray = [[DBDataBaseManager shareDataBaseManager] queryIsLookedCountWithTableName:kNotificationOne];
            
            [[NSUserDefaults standardUserDefaults] setInteger:notLookedArray.count forKey:@"kNotificationOneIsLookedCount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //            if (_kNotificationOneCountBlock) {
            //                _kNotificationOneCountBlock(notLookedArray.count);
            //            }
            
            if (notLookedArray.count > 0) {
                
                self.isHiddenXiaoXiRedTips = NO;
                
            }else{
                self.isHiddenXiaoXiRedTips = YES;
            }
            
            
            
        }else{
//            PopInfo(failMsg);
        }
        
        [self.collectionView reloadData];

        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
    
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
            PopInfo(failMsg);

        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}

- (void)configCollectionView{
    self.collectionView.backgroundColor = LightHexColcor;
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
            
        }else{
            PopInfo(failMsg);

        }
        [self.collectionView reloadData];

        
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
            
            
        }else{
            PopInfo(failMsg);

        }
        [self.collectionView reloadData];

        
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
        header.redLabel.hidden = self.isHiddenXiaoXiRedTips;
        
        
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
        
        
        //消息
        [header setScanButtonBlock:^{
            XiaoXiViewController *vc = [[XiaoXiViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }];
        
        //复投
        [header setFutouButtonBlock:^{
            
            [self showAlertViewWithType:AlertTypePassword title:@"请输入登录密码"];
            
            
        }];
        
        
        //母币买入
        [header setMaiRuButtonBlock:^{
            
            MuBiMaiRuViewController *vc = [[MuBiMaiRuViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
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


- (void)showAlertViewWithType:(AlertType)type title:(NSString *)title{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        if (userNameTextField.text.length == 0) {
            return ;
        }
        
        switch (type) {
            case AlertTypePassword:
                
                [self configPasswordWithText:userNameTextField.text];
                
                
                break;
           
            case AlertTypeNum:
                
                [self configFuTouNumWithNum:userNameTextField.text];
                
                
                break;
                
                
                
                
            default:
                break;
        }
        
        
        
    }]];
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
        
        textField.placeholder = title;
        switch (type) {
            case AlertTypePassword:
                
                textField.secureTextEntry=YES;
                
                break;
                
                
            case AlertTypeNum:
                
                textField.keyboardType = UIKeyboardTypeNumberPad;
                
                break;
            default:
                break;
        }
        
        
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}


#pragma mark -- 验证支付密码
- (void)configPasswordWithText:(NSString *)text{
    [App_HttpsRequestTool loginLoginRequestMobile:[App_UserManager phone] password:text withSuccess:^(id responseObject) {
        
        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            
            [self showAlertViewWithType:AlertTypeNum title:@"请输入复投数量"];
            
        }else{
            PopInfo(failMsg);

        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}

#pragma mark -- 验证复投数量
- (void)configFuTouNumWithNum:(NSString *)text{
    
    
    [App_HttpsRequestTool mineFuTouWithqkd:text WithSuccess:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        
        if ([response isSuccess]) {
            
            PopSuccess(@"复投成功");
            
            [self loadData];
            
            [self configXiaoXiList];
            
        }else{
            PopInfo(failMsg);

        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
    
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
        
        MaiChuViewController *vc = [[MaiChuViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 4) {//推广链接
        
        TuiGuangViewController *vc = [[TuiGuangViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 5) {//意见反馈
        
        YiJianFanKuiViewController *vc = [[YiJianFanKuiViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
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

- (NSMutableArray *)xiaoxiDataSource{
    if (_xiaoxiDataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _xiaoxiDataSource = array;
    }
    return _xiaoxiDataSource;
}



@end
