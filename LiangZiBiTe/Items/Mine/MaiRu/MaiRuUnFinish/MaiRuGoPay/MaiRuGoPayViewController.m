//
//  MaiRuGoPayViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MaiRuGoPayViewController.h"
#import "MaiRuGoPayNormallCell.h"
#import "MaiRuGoPayPhotoCell.h"
#import "MaiRuGoPayCommitCell.h"
#import "MaiRuGoPayResponse.h"
#import "ZZYPhotoHelper.h"

static NSString *normallCellID = @"MaiRuGoPayNormallCell";
static NSString *photoCleeID = @"MaiRuGoPayPhotoCell";
static NSString *commitCleeID = @"MaiRuGoPayCommitCell";




@interface MaiRuGoPayViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) MaiRuGoPayModel *model;


@property (nonatomic, strong) NSData *imageData;

@property (nonatomic, copy) NSString *beizhiStr;

@end

@implementation MaiRuGoPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LightHexColcor;

    [self setNavgiationBarTitle:@"打款"];

    [self configTableView];
    
    [self loadData];
    
}

- (void)loadData{
    
    [App_HttpsRequestTool mineMaiRuUnfinishSelectPayInfoWithOrderID:self.orderid Success:^(id responseObject) {
        
        MaiRuGoPayResponse *respons = [[MaiRuGoPayResponse alloc] initWithDictionary:responseObject error:nil];
        if ([respons isSuccess]) {
            
            MaiRuGoPayModel *model = respons.data;
            
            self.model = model;
            
            
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [array addObject:[NSString stringWithFormat:@"收款人手机号：%@", ADDOBJECT(model.skrsjhm)]];
//            [array addObject:[NSString stringWithFormat:@"%@", ADDOBJECT(@"银行卡信息")]];
            [array addObject:[NSString stringWithFormat:@"银行名称：%@", ADDOBJECT(model.skfs)]];
            [array addObject:[NSString stringWithFormat:@"开户行：%@", ADDOBJECT(model.kaihh)]];
            [array addObject:[NSString stringWithFormat:@"收款人姓名：%@", ADDOBJECT(model.shrxm)]];
            [array addObject:[NSString stringWithFormat:@"收款人账号：%@", ADDOBJECT(model.skzh)]];
            [array addObject:[NSString stringWithFormat:@"支付宝账号：%@", ADDOBJECT(model.zfbzh)]];
            [array addObject:[NSString stringWithFormat:@"微信账号：%@", ADDOBJECT(model.wxzh)]];
        
            [self.dataSource addObjectsFromArray:array];

//            skfs    类型    银行名称
//            kaihh    类型    开户行
//            shrxm    类型    收款人姓名
//            skzh    类型    收款账号
//            skrsjhm    类型    收款人手机号码
//            zfbzh    类型    支付宝账号
//            wxzh    类型    微信账号
            
            
        }else{
            PopInfo(failMsg);
        }
        
        [self.tableView reloadData];

        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:normallCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:normallCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:photoCleeID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:photoCleeID];
    
    [self.tableView registerNib:[UINib nibWithNibName:commitCleeID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:commitCleeID];

}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataSource.count;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1){
        return 350;
    }else{
        return 90;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MaiRuGoPayNormallCell *cell = [tableView dequeueReusableCellWithIdentifier:normallCellID];
        cell.contentLabel.text = self.dataSource[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        MaiRuGoPayPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:photoCleeID];
        
        [cell.beizhuTextField addTarget:self action:@selector(beizhuTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];
        
        __weak typeof(cell) weakcell = cell;
        [cell setLogImageViewBlock:^{
           
            
            [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
                NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
                weakcell.logImageView.image = [UIImage imageWithData:imagedata];
                self.imageData = imagedata;
                
            }];
            
        }];
        
        return cell;
    }else{

        MaiRuGoPayCommitCell *cell = [tableView dequeueReusableCellWithIdentifier:commitCleeID];
        [cell setCommitButtonBlock:^{
            [self commitInfo];
        }];
        return cell;
        
    }
    
    
}

- (void)commitInfo{
    
    if (self.beizhiStr.length == 0) {
        
        PopInfo(@"请填写备注信息");
        return;
    }
    
    
    if (self.imageData.length == 0) {
        
        PopInfo(@"请上传支付凭证");
        return;
    }
    
    PopLoading(@"提交中");
    [App_HttpsRequestTool mineMaiRuUnfinishSelectPayInfoCommitWithorderid:self.orderid beizhu:self.beizhiStr pztp:self.imageData Success:^(id responseObject) {
        PopDismiss;
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"提交成功");

            if (self->_refreshDataAfterPay) {
                self->_refreshDataAfterPay();
            }
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
        }else{
            PopError(failMsg);
            
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
        PopDismiss;
    }];
    
    
}

- (void)beizhuTextFieldClicked:(UITextField *)textField{
    
    self.beizhiStr = textField.text;
    
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
    return 0.0000001;
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}



@end
