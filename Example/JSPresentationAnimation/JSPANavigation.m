//
//  JSPANavigation.m
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSPANavigation.h"

@implementation JSPANavigation

static float const transform = -0.005;

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _reverse = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return jspa_animation_navigation_duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    CGFloat direction = self.reverse ? -1 : 1;
    
    toView.layer.anchorPoint = CGPointMake(direction == 1 ? 0 : 1, 0.5);
    fromView.layer.anchorPoint = CGPointMake(direction == 1 ? 1 : 0, 0.5);
    
    CATransform3D viewFromTransform = CATransform3DMakeRotation(direction * M_PI_2, 0.0, 1.0, 0.0);
    CATransform3D viewToTransform = CATransform3DMakeRotation(-direction * M_PI_2, 0.0, 1.0, 0.0);
    viewFromTransform.m34 = transform;
    viewToTransform.m34 = transform;
    
    [containerView setTransform:CGAffineTransformMakeTranslation(direction * containerView.frame.size.width / 2.0, 0)];
    [toView.layer setTransform:viewToTransform];
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:jspa_animation_navigation_spring_delay
         usingSpringWithDamping:jspa_animation_navigation_spring_damping
          initialSpringVelocity:jspa_animation_navigation_spring_velocity
                        options:jspa_animation_navigation_spring_option
                     animations:^{
                         containerView.transform = CGAffineTransformMakeTranslation(-direction * containerView.frame.size.width / 2.0, 0);
                         fromView.layer.transform = viewFromTransform;
                         toView.layer.transform = CATransform3DIdentity;
                     } completion:^(BOOL finished) {
                         containerView.transform = CGAffineTransformIdentity;
                         fromView.layer.transform = CATransform3DIdentity;
                         toView.layer.transform = CATransform3DIdentity;
                         fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
                         toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
                         
                         if ([transitionContext transitionWasCancelled]) {
                             [toView removeFromSuperview];
                         } else {
                             [fromView removeFromSuperview];
                         }
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
