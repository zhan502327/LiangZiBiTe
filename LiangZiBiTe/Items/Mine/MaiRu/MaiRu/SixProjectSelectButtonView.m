//
//  SixProjectSelectButtonView.m
//  LiangZiBiTe
//
//  Created by zhandb on 2018/9/10.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "SixProjectSelectButtonView.h"

@implementation SixProjectSelectButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SixProjectSelectButtonView" owner:nil options:nil] lastObject];
        self.frame = frame;
       
        for (UIButton *button in self.contentView.subviews) {
            if (button.isSelected == YES) {
                [button setBackgroundColor:HexColor(0X115BBB)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
        }
        
    }
    return self;
}

- (void)setButtonTitleArray:(NSArray *)buttonTitleArray{
    _buttonTitleArray = buttonTitleArray;
    
    for (int i = 0; i<buttonTitleArray.count; i++) {
        
        UIButton *button = (UIButton *)self.contentView.subviews[i];
        
        NSString *title = self.buttonTitleArray[i];
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateSelected];
        
    }
    
}



- (IBAction)createButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
 
    if (button.isSelected == NO) {
        
        [self configButtonBackGroundColorWithButton:button];
    }
    
    if (_oneButtonBlock) {
        _oneButtonBlock();
    }

    
}

- (IBAction)unfinishButtonCLicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.isSelected == NO) {
        
        [self configButtonBackGroundColorWithButton:button];
    }

    if (_twoButtonBlock) {
        _twoButtonBlock();
    }
}

- (IBAction)payButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.isSelected == NO) {
        
        [self configButtonBackGroundColorWithButton:button];
    }
    if (_threeButtonBlock) {
        _threeButtonBlock();
    }

}

- (IBAction)finishButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.isSelected == NO) {
        
        [self configButtonBackGroundColorWithButton:button];
    }
    if (_fourButtonBlock) {
        _fourButtonBlock();
    }

}

- (IBAction)listButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.isSelected == NO) {
        
        [self configButtonBackGroundColorWithButton:button];
    }
    if (_fiveButtonBlock) {
        _fiveButtonBlock();
    }
}

- (IBAction)centerButtonCLicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.isSelected == NO) {
        
        [self configButtonBackGroundColorWithButton:button];
    }
    if (_sixButtonBlock) {
        _sixButtonBlock();
    }

}

- (void)configButtonBackGroundColorWithButton:(UIButton *)button{
    button.selected = !button.isSelected;

    if (button.isSelected == YES) {
        button.backgroundColor = HexColor(0X115BBB);
        
        for (UIButton *otherButton in self.contentView.subviews) {
            if (otherButton.tag == button.tag) {
                
            }else{
                otherButton.selected = !button.isSelected;
                
                otherButton.backgroundColor = [UIColor whiteColor];
            }
            
        }
        
    }
}



@end
