//
//  PresentingAnimator.m
//  POPList
//
//  Created by zhuke on 2018/6/5.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "PresentingAnimator.h"
#import "POP.h"
#import <YYKit/YYKit.h>

@implementation PresentingAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    // PresentingView
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    // Dimming view
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
    dimmingView.backgroundColor = UIColorHex(545454);
    dimmingView.layer.opacity = 0.0;
    
    // Creat to view
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.size = CGSizeMake(transitionContext.containerView.width - 104.f, transitionContext.containerView.height - 288.f);
    toView.center = CGPointMake(transitionContext.containerView.centerX, -transitionContext.containerView.centerY);
    
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];
    
    // POP animation
    // To view position y and from value scale
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(transitionContext.containerView.centerY);
    positionAnimation.springBounciness = 10;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    scaleAnimation.springBounciness = 20;
    
    // DimmingView layer opacity
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.2);
    
    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleXY"];
    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionY"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacity"];

}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

@end
