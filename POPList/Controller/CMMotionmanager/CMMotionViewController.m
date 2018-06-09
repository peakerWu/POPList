//
//  CMMotionViewController.m
//  POPList
//
//  Created by zhuke on 2018/6/7.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "CMMotionViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <YYKit/YYKit.h>

@interface CMMotionViewController (){
    UIDynamicAnimator *_dynamicAnimator; // 物理仿真动画
    UIDynamicItemBehavior *_dynamicItemBehavior; // 物理仿真行为
    UIGravityBehavior *_gravityBehavior; // 重力行为
    UICollisionBehavior *_collisionBehavior; // 碰撞行为
    
    UIView *_referenceView; // 碰撞的view
}
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) UIButton *sharkTagButton;
@end

@implementation CMMotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDynamic];
    [self creatGyro];
    
    _referenceView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300)];
    _referenceView.backgroundColor = UIColorHex(2db7b5);
    [self.view addSubview:_referenceView];
    
    NSLog(@"%@", NSStringFromCGPoint(_referenceView.center));
    
    UIButton *sharkTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sharkTagButton setTitle:@"sharkTagButton" forState:UIControlStateNormal];
    [sharkTagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_referenceView addSubview:sharkTagButton];
    [sharkTagButton setBackgroundColor:[UIColor redColor]];
    sharkTagButton.frame = CGRectMake(75, 30, 150, 40);
    self.sharkTagButton = sharkTagButton;
    
    [_dynamicItemBehavior addItem:sharkTagButton];
    [_gravityBehavior addItem:sharkTagButton];
    [_collisionBehavior addItem:sharkTagButton];
    
    
    // Do any additional setup after loading the view.
}

- (void)creatGyro {
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    if ([self.motionManager isDeviceMotionAvailable]) {
        self.motionManager.deviceMotionUpdateInterval = 1.0f/100.0f; //1秒100次
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            double gravityX = motion.gravity.x;
            double gravityY = motion.gravity.y;
            
            _gravityBehavior.angle = atan2(gravityX, gravityY) - M_PI_2;
        }];
    }
}

- (void)createDynamic
{
    
    // 创建现实动画
    _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // 创建物理仿真行为
    _dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[]];
    _dynamicItemBehavior.elasticity = 0.5;  // 弹性系数 值越大弹力值越大
    
    // 重力仿真
    _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[]];
    CGFloat dy = 2;
    _gravityBehavior.gravityDirection = CGVectorMake(0, dy);
    // 碰撞仿真
    _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[]];
    _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES; // 开启碰撞检测
    
    // 将行为添加到动画中
    [_dynamicAnimator addBehavior:_dynamicItemBehavior];
    [_dynamicAnimator addBehavior:_gravityBehavior];
    [_dynamicAnimator addBehavior:_collisionBehavior];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)gyro
{
    // 陀螺仪
    if (self.motionManager.gyroAvailable) {
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            
        }];
        
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if(fabs(motion.attitude.roll)<1.0f)
            {
                
                [UIView animateWithDuration:0.6 animations:^{
                    self.sharkTagButton.layer.transform = CATransform3DMakeRotation(-(motion.attitude.roll), 0, 0, 1);
                    
                }];
            }else if (fabs(motion.attitude.roll)<1.5f)
            {
                [UIView animateWithDuration:0.6 animations:^{
                    int s;
                    if (motion.attitude.roll>0)
                    {
                        s=-1;
                    }else
                    {
                        s = 1;
                    }
                    self.sharkTagButton.layer.transform = CATransform3DMakeRotation(s*M_PI_2, 0, 0, 1);
                }];
            }
            if ((motion.attitude.pitch)<0)
            {
                [UIView animateWithDuration:0.6 animations:^{
                    self.sharkTagButton.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
                }];
            }
        }];
    }
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
