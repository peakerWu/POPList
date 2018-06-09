//
//  PictureViewController.m
//  POPList
//
//  Created by zhuke on 2018/6/5.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "PictureViewController.h"
#import "POP.h"
#import <YYKit/YYKit.h>

#define kOriginalSize CGSizeMake(182, 118)
#define kEnlargeSize CGSizeMake(320, 208)

@interface PictureViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Enlarge" forState:UIControlStateNormal];
    [button setTitle:@"Shrink" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    button.size = CGSizeMake(100, 40);
    button.centerX = self.view.centerX;
    button.centerY = self.view.height - 80;
    [self.view addSubview:button];
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.size = kOriginalSize;
    self.imageView.center = self.view.center;
    self.imageView.image = [UIImage imageNamed:@"corsica"];
    [self.view addSubview:self.imageView];
    
    
    // Do any additional setup after loading the view.
}

- (void)buttonDidClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    spring.springBounciness = 4;  // 弹力越大，振幅越大
    spring.springSpeed = 12;   // 速度越大结束越早
    if (sender.selected) {
        spring.toValue = [NSValue valueWithCGSize:kEnlargeSize];
    } else {
        spring.toValue = [NSValue valueWithCGSize:kOriginalSize];
    }
    [self.imageView pop_addAnimation:spring forKey:@"enlarge"];
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
