//
//  JSPADismissal.m
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSPADismissal.h"

@implementation JSPADismissal

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return jspa_animation_dismissal_duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);

    if (self.dismissal == JSPAAnimationDismissalRotate) {
        [self performRotationDismissal:transitionContext];
        return;
    }
    
    if (self.dismissal == JSPAAnimationDismissalDepth) {
        [self performScaleBehindDismissal:transitionContext];
        return;
    }
    
    if (self.dismissal == JSPAAnimationDismissalFromMiddle) {
        [self performScaleDownMiddleDismissal:transitionContext];
        return;
    }
}

- (void)performRotationDismissal:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];

    CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI);
    UIView *container = [transitionContext containerView];
    fromVC.view.frame = sourceRect;
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.0);
    fromVC.view.layer.position = CGPointMake(160.0, 0);
    
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    
    toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.0);
    toVC.view.layer.position = CGPointMake(160.0, 0);
    toVC.view.transform = CGAffineTransformMakeRotation(-M_PI);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:jspa_animation_dismissal_spring_delay
         usingSpringWithDamping:jspa_animation_dismissal_spring_damping
          initialSpringVelocity:jspa_animation_dismissal_spring_velocity
                        options:jspa_animation_dismissal_spring_option
                     animations:^{
                         fromVC.view.center = CGPointMake(fromVC.view.center.x - 320, fromVC.view.center.y);
                         toVC.view.transform = CGAffineTransformMakeRotation(-0);
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)performScaleBehindDismissal:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    toViewController.view.alpha = 0.5;

    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    UIView *snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = fromViewController.view.frame;
    [containerView addSubview:snapshotView];
    
    [fromViewController.view removeFromSuperview];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:jspa_animation_dismissal_spring_delay
         usingSpringWithDamping:jspa_animation_dismissal_spring_damping
          initialSpringVelocity:jspa_animation_dismissal_spring_velocity
                        options:jspa_animation_dismissal_spring_option
                     animations:^{
                         toViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         toViewController.view.alpha = 1.0f;
                         snapshotView.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height);;
                     } completion:^(BOOL finished) {
                         [snapshotView removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)performScaleDownMiddleDismissal:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    toViewController.view.alpha = 0.5;
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    UIView *snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = fromViewController.view.frame;
    [containerView addSubview:snapshotView];
    
    [fromViewController.view removeFromSuperview]; [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:jspa_animation_dismissal_spring_delay
         usingSpringWithDamping:jspa_animation_dismissal_spring_damping
          initialSpringVelocity:jspa_animation_dismissal_spring_velocity
                        options:jspa_animation_dismissal_spring_option
                     animations:^{
                         snapshotView.frame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width / 2, fromViewController.view.frame.size.height / 2);
                         toViewController.view.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [snapshotView removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}


@end
