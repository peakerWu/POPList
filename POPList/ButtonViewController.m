//
//  ButtonViewController.m
//  POPList
//
//  Created by zhuke on 2018/6/5.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "ButtonViewController.h"
#import "POP.h"
#import <YYKit/YYKit.h>

#define kStartSize CGSizeMake(34, 34)
#define kAnimationSize CGSizeMake(44, 44)

@interface ButtonViewController ()
{
    UIButton *_button;
    BOOL _buttonToggle;
}

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button = [[UIButton alloc] init];
    _button.size = kStartSize;
    _button.center = self.view.center;
    _button.tintColor = [UIColor redColor];
    
    // imageWithRenderingMode 为了设置tintColor时候生效。 UIImageRenderingModeAlwaysTemplate：总是绘制临时图片
    [_button setImage:[[UIImage imageNamed:@"cross"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    
    [_button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)buttonDidClicked:(UIButton *)sender
{
    _buttonToggle = !_buttonToggle;
    CALayer *layer = sender.layer;
    // First, let's remove any existing animations
    [layer removeAllAnimations];
    
    // 弹性size改变  与  旋转
    POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    POPSpringAnimation *rotation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    if (_buttonToggle) {
        ani.toValue = [NSValue valueWithCGSize:kAnimationSize];
        rotation.toValue = @(M_PI_4);
        sender.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    } else {
        ani.toValue = [NSValue valueWithCGSize:kStartSize];
        rotation.toValue = @(0);
        sender.tintColor = [UIColor redColor];
    }
    
    ani.springBounciness = 20;
    ani.springSpeed = 16;
    [layer pop_addAnimation:ani forKey:@"size"];
    [layer pop_addAnimation:rotation forKey:@"rotation"];
    
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
