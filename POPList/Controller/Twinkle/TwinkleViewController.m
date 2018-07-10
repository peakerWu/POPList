//
//  TwinkleViewController.m
//  POPList
//
//  Created by zhuke on 2018/7/10.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "TwinkleViewController.h"
#import "POP.h"

@interface TwinkleViewController ()

@end

@implementation TwinkleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    circleView.center = self.view.center;
    circleView.layer.cornerRadius = 15;
    circleView.layer.masksToBounds = YES;
    circleView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:circleView];
    
    // Add basic animation
    POPBasicAnimation *opAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opAnimation.duration = 1;
    opAnimation.autoreverses = YES;
    opAnimation.repeatForever = YES;
    opAnimation.fromValue = @(0.3);
    opAnimation.toValue = @(0.5);
    
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnimation.duration = 1;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatForever = YES;
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.3, 0.3)]; //
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.6, 0.6)]; //
    
    // when add two or more animations, add code must togather.
    [circleView.layer pop_addAnimation:opAnimation forKey:@"opacity"];
    [circleView.layer pop_addAnimation:scaleAnimation forKey:@"scale"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
