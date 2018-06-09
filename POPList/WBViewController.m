//
//  WBViewController.m
//  POPList
//
//  Created by zhuke on 2018/6/5.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "WBViewController.h"
#import <YYKit/YYKit.h>
#import "POP.h"

@interface WBViewController ()

@property (nonatomic, strong) UIView *presentView;

@property (nonatomic, strong) UIButton *dismissBtn;
@end

@implementation WBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    presentButton.tintColor = [UIColor cyanColor];
    presentButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [presentButton setTitle:@"Present" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(presentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:presentButton];
    presentButton.size = CGSizeMake(200, 40);
    presentButton.centerX = self.view.centerX - 104/2;
    presentButton.centerY = self.view.centerY - 288/2;
    
    
    [self.presentView addSubview:self.dismissBtn];
    [self.dismissBtn addTarget:self action:@selector(blueButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)presentView:(UIButton *)sender
{
    self.view.userInteractionEnabled = NO;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.presentView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    POPBasicAnimation *opacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacity.toValue = @(0.5);
    opacity.duration = 0.25;
    [self.presentView.layer pop_addAnimation:opacity forKey:@"opacity"];
    
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [UIView animateWithDuration:5 animations:^{
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            
            POPBasicAnimation *opacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            opacity.toValue = @(0);
            opacity.duration = 2.0;
            [self.presentView.layer pop_addAnimation:opacity forKey:@"opacity"];
            
            [self.presentView removeFromSuperview];
            self.view.userInteractionEnabled = YES;
        }];
    }];
    [self.presentView addGestureRecognizer:tap];
}

- (void)blueButtonDidClicked:(UIButton *)sender
{
    [UIView animateWithDuration:5 animations:^{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [sender.superview removeFromSuperview];
        if (!self.view.userInteractionEnabled) {
            self.view.userInteractionEnabled = YES;
        }
    }];
}
- (UIView *)presentView
{
    if (!_presentView) {
        _presentView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _presentView.layer.opacity = 0;
        _presentView.backgroundColor = UIColorHex(#2db7b5);
        _presentView.userInteractionEnabled = YES;
        
    }
    return _presentView;
}

- (UIButton *)dismissBtn
{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissBtn.frame = CGRectMake(0, 0, 100, 40);
        _dismissBtn.center = [UIApplication sharedApplication].keyWindow.center;
        [_dismissBtn setTitle:@"Dismiss" forState:UIControlStateNormal];
        [_dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _dismissBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
