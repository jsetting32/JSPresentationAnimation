//
//  JSPAPresentation.m
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSPAPresentation.h"

@implementation JSPAPresentation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return jspa_animation_presentation_duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);

    if (self.presentation == JSPAAnimationPresentationDepth) {
        [self performScaleBehindPresentation:transitionContext];
        return;
    }

    if (self.presentation == JSPAAnimationPresentationFromTop) {
        [self performFromTopPresentation:transitionContext];
        return;
    }
    
    if (self.presentation == JSPAAnimationPresentationRotate) {
        [self performRotationPresentation:transitionContext];
        return;
    }
}

- (void)performScaleBehindPresentation:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForToVc = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    toViewController.view.frame = CGRectOffset(finalFrameForToVc, 0, bounds.size.height);
    [containerView addSubview:toViewController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:jspa_animation_presentation_spring_delay
         usingSpringWithDamping:jspa_animation_presentation_spring_damping
          initialSpringVelocity:jspa_animation_presentation_spring_velocity
                        options:jspa_animation_presentation_spring_option
                     animations:^{
                         fromViewController.view.alpha = 0.7;
                         fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         toViewController.view.frame = finalFrameForToVc;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         toViewController.view.alpha = 1.0;
                     }];
}

- (void)performFromTopPresentation:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForToVc = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    toViewController.view.frame = CGRectOffset(finalFrameForToVc, 0, -bounds.size.height);
    [containerView addSubview:toViewController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:jspa_animation_presentation_spring_delay
         usingSpringWithDamping:jspa_animation_presentation_spring_damping
          initialSpringVelocity:jspa_animation_presentation_spring_velocity
                        options:jspa_animation_presentation_spring_option
                     animations:^{
                         fromViewController.view.alpha = 0.5;
                         toViewController.view.frame = finalFrameForToVc;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         fromViewController.view.alpha = 1.0;
                     }];
}

- (void)performRotationPresentation:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];

    CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI);
    fromVC.view.frame = sourceRect;
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.0);
    fromVC.view.layer.position = CGPointMake(160.0, 0);
    
    UIView *container = [transitionContext containerView];
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    CGPoint final_toVC_Center = toVC.view.center;
    
    toVC.view.center = CGPointMake(-sourceRect.size.width, sourceRect.size.height);
    toVC.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:jspa_animation_presentation_spring_delay
         usingSpringWithDamping:jspa_animation_presentation_spring_damping
          initialSpringVelocity:jspa_animation_presentation_spring_velocity
                        options:jspa_animation_presentation_spring_option
                     animations:^{
                         fromVC.view.transform = rotation;
                         toVC.view.center = final_toVC_Center;
                         toVC.view.transform = CGAffineTransformMakeRotation(0);
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
