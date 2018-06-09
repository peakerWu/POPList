//
//  CountdownViewController.m
//  POPList
//
//  Created by zhuke on 2018/6/5.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "CountdownViewController.h"
#import "POP.h"

@interface CountdownViewController ()
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation CountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.backgroundColor = [UIColor grayColor];
    _countLabel.textColor = [UIColor blackColor];
    _countLabel.text = @"00:00:00";
    _countLabel.font = [UIFont systemFontOfSize:24.0];
    _countLabel.frame = CGRectMake(0, 0, 200, 40);
    _countLabel.center = self.view.center;
    [self.view addSubview:_countLabel];
    
    //  这个和下面的两行代码等价
    POPBasicAnimation *countAni = [POPBasicAnimation linearAnimation];
//    POPBasicAnimation *countAni1 = [POPBasicAnimation animation];
//    countAni1.timingFunction = kCAMediaTimingFunctionLinear;
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"count++" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(id obj, CGFloat *values) {
            values[0] = [[obj description] floatValue];
            NSLog(@"%f, %f", values[0], values[1]);
        };
        prop.writeBlock = ^(id obj, const CGFloat *values) {
            UILabel *label = (UILabel *)obj;
            label.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)values[0]/60, (int)values[0]%60, (int)(values[0]*100)%100];
        };
        prop.threshold = 0.01; // 值设置的越大，writeBlock的执行次数越少
    }];
    // 设置动画的属性
    countAni.property = prop;
    countAni.fromValue = @(0);
    countAni.toValue = @(2*60);
    countAni.duration = 2*60;
    countAni.beginTime = CACurrentMediaTime() + 2.0;
    countAni.autoreverses = YES;
    [_countLabel pop_addAnimation:countAni forKey:@"count"];
    
    // Do any additional setup after loading the view.
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
