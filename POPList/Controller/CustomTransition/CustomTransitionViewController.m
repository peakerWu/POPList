//
//  CustomTransitionViewController.m
//  POPList
//
//  Created by zhuke on 2018/6/6.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "CustomTransitionViewController.h"
#import <YYKit/YYKit.h>
#import "ModalViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"

@interface CustomTransitionViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation CustomTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [presentButton setTitle:@"模态一个窗口" forState:UIControlStateNormal];
    [presentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
    presentButton.size = CGSizeMake(200, 40);
    presentButton.center = self.view.center;
    
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

- (void)present:(UIButton *)sender
{
    ModalViewController *modal = [[ModalViewController alloc] init];
    modal.modalPresentationStyle = UIModalPresentationCustom;
    modal.transitioningDelegate = self;
    
    [self.navigationController presentViewController:modal animated:YES completion:nil];
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
