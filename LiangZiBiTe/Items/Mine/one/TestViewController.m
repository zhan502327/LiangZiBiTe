//
//  TestViewController.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/8/26.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "TestViewController.h"
#import "PNChart/PNChart.h"

@interface TestViewController ()<PNChartDelegate>

@property (nonatomic, weak) PNLineChart *lineChart;


@property (nonatomic) PNBarChart * barChart;

@property (nonatomic, weak) UIButton *refreshDataButton;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self refreshDataButton];
    
//    [self getHistorycharData];
    
    // Y轴设置
    self.lineChart.yFixedValueMax = 80;
    self.lineChart.yFixedValueMin = 0;
    
    
    [self.lineChart setYLabels:@[@"0",@"20",@"40",@"60",@"80"]];
    
    //    [self.lineChart setXLabels:@[@"0",@"4",@"8",@"12",@"16",@"20",@"24",@"0",@"4",@"8",@"12",@"16",@"20",@"24",@"0",@"4",@"8",@"12",@"16",@"20",@"24",@"0",@"4",@"8",@"12",@"16",@"20",@"24",@"0",@"4",@"8",@"12",@"16",@"20",@"24",@"0",@"4",@"8",@"12",@"16",@"20",@"24",@"0",@"4",@"8",@"12",@"16",@"20",@"24"]];
    
    
    
    //    [self initLineChart];
    
    //    [self syslineChart];
}


////发送请求获取曲线数据
//- (void)getHistorycharData
//{
//
//    //组装参数
//    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
//    params[@"a_id"] = @"167";//康贵101
//    //说明是哪条曲线
//    params[@"num"] = @"1,2,3,4,5,6,10";
//
//    params[@"model"] = @"avg";
//
//    /**h小时 d天 w周 m月 q季度 hy半年 y年*/
//    params[@"type"] = @"d";
//    params[@"time"] = @"20180101";

    
//    //请求数据     //    type=hy&model=avg&num=1&time=201702&a_id=58
//    [App_HttpsRequestTool textWithDic:params withSuccess:^(id responseObject) {
//
//
//        NSDictionary *result = (NSDictionary *)responseObject;
//
//
//        NSDictionary *data = result[@"data"];
//        if (data[@"1"]) {
//            NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:0];
//
//            NSMutableArray *xarray = [NSMutableArray arrayWithCapacity:0];
//
//            for (NSDictionary *dic in data[@"1"]) {
//
//                [array1 addObject:dic[@"y"]];
//                [xarray addObject:@""];
//            }
//
//            [self.lineChart setXLabels:xarray];
//
//            // 第一组数据
//            PNLineChartData *data01 = [PNLineChartData new];
//            data01.dataTitle = @"Alpha";
//            data01.alpha = 1;
//
//            //设置折线的颜色
//            data01.color = [UIColor redColor];
//            //设置折线的宽度
//            data01.lineWidth = 1;
//            //设置折线的点数
//            data01.itemCount = array1.count;
//            //设置折点的样式
//            data01.inflexionPointStyle = PNLineChartPointStyleNone;
//            //设置折点的颜色
//            data01.inflexionPointColor = [UIColor redColor];
//            //设置折点的大小
//            data01.inflexionPointWidth = 3.0f;
//            //设置是否展示折点的Label
//            data01.showPointLabel = NO;
//            //设置折点的文本颜色
//            data01.pointLabelColor = [UIColor blackColor];
//            //设置折点的文本字体
//            data01.pointLabelFont = [UIFont systemFontOfSize:12];
//
//
//            data01.getData = ^(NSUInteger index) {
//                CGFloat yValue = [array1[index] floatValue];
//                return [PNLineChartDataItem dataItemWithY:yValue];
//            };
//
//            // 加入数据源
//            self.lineChart.chartData = @[data01];
//            // 渲染出来
//            [self.lineChart strokeChart];
//        }
//
//
//    } failure:^(NSError *error) {
//        PopError(netError);
//    }];
//
//}


- (PNLineChart *)lineChart{
    
    if (_lineChart == nil) {
        PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 40, Current_Width - 40, 200)];
        // 设计X轴
        lineChart.yLabelFormat = @"%1.f";
        lineChart.backgroundColor = [UIColor whiteColor];
        // 是否显示轴,默认为NO
        lineChart.showCoordinateAxis = YES;
        //设置是否显示Y轴的数值
        lineChart.showGenYLabels = YES;
        //设置是否显示横向虚线
        lineChart.showYGridLines = YES;
        //设置轴的宽度
        lineChart.axisWidth = 1.0f;
        
        //设置轴的颜色
        lineChart.axisColor = [UIColor grayColor];
        
        //是否展示平滑线条
        lineChart.showSmoothLines = YES;
        
        lineChart.delegate = self;
        [self.view addSubview:lineChart];
        
        _lineChart = lineChart;
        
    }
    return _lineChart;
    
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex {
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d", point.x, point.y, (int) lineIndex, (int) pointIndex);
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex {
    NSLog(@"Click on line %f, %f, line index is %d", point.x, point.y, (int) lineIndex);
}


- (void)userClickedOnBarAtIndex:(NSInteger)barIndex {
    
    NSLog(@"Click on bar %@", @(barIndex));
    
    
    PNBar *bar = self.barChart.bars[(NSUInteger) barIndex];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = @1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = @1.1;
    animation.duration = 0.2;
    animation.repeatCount = 0;
    animation.autoreverses = YES;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [bar.layer addAnimation:animation forKey:@"Float"];
}


- (UIButton *)refreshDataButton{
    if (_refreshDataButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(100, Current_Height - 200, Current_Width - 200, 50);
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"ReFresh Data" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(refreshDataButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        _refreshDataButton = button;
    }
    return _refreshDataButton;
}

- (void)refreshDataButtonClicked{
    
//    [self getHistorycharData];
}
















//
//

////    self.lineChart.delegate = self;
//
//    [self.view addSubview:self.lineChart];
//
//    self.lineChart.legendStyle = PNLegendItemStyleSerial;
//    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
//    self.lineChart.legendFontColor = [UIColor redColor];
//
//    // 放标注的框框
//    UIView *legend = [self.lineChart getLegendWithMaxWidth:100];
//    [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
//    [self.view addSubview:legend];
//
//
//}
@end
