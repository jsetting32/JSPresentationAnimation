//
//  JSPAInteraction.m
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSPAInteraction.h"
#import "JSPresentationAnimation.h"

@implementation JSPAInteraction

- (instancetype)init {
    if (!(self = [super init])) return nil;    
    _shouldCompleteTransition = NO;
    _transitionInProgress = NO;
//    var completionSeed: CGFloat {
//        return 1 - percentComplete
//    }
    
    return self;
}

- (void)attachToViewController:(UIViewController *)viewController {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    self.navigationController = viewController.navigationController;
    [self setupGestureRecognizer:viewController.view];
}

- (void)setupGestureRecognizer:(UIView *)view {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    [view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)]];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    CGPoint viewTranslation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan:{
            self.transitionInProgress = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGFloat delta = fminf(fmaxf(viewTranslation.x / 200.0f, 0.0f), 1.0f);
            self.shouldCompleteTransition = delta > 0.5;
            [self updateInteractiveTransition:delta];
            break;
        }
        case (UIGestureRecognizerStateCancelled, UIGestureRecognizerStateEnded):{
            self.transitionInProgress = NO;
            if (!self.shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            NSLog(@"We're falling back to the default case");
            break;
    }
}

@end
