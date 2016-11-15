//
//  JSPAManager.m
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSPAManager.h"
#import <objc/runtime.h>

@interface JSPAManager()
@property (strong, nonatomic) JSPAInteraction *js_animation_interaction;
@property (strong, nonatomic) JSPANavigation *js_animation_navigation;
@property (strong, nonatomic) JSPADismissal *js_animation_dismissal;
@property (strong, nonatomic) JSPAPresentation *js_animation_presentation;
@property (weak, nonatomic, readwrite) UIViewController *viewController;
@end

@implementation JSPAManager

- (instancetype)init {
    if (!(self = [super init])) return nil;
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    _js_animation_interaction = [[JSPAInteraction alloc] init];
    _js_animation_navigation = [[JSPANavigation alloc] init];

    _js_animation_dismissal = [[JSPADismissal alloc] init];
    _js_animation_dismissal.dismissal = JSPAAnimationDismissalDepth;
    
    _js_animation_presentation = [[JSPAPresentation alloc] init];
    _js_animation_presentation.presentation = JSPAAnimationPresentationDepth;
    return self;
}

- (void)setDismissal:(JSPAAnimationDismissal)dismissal {
    self.js_animation_dismissal.dismissal = dismissal;
}

- (void)setPresentation:(JSPAAnimationPresentation)presentation {
    self.js_animation_presentation.presentation = presentation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    return self.js_animation_dismissal;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    return self.js_animation_presentation;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    if (operation == UINavigationControllerOperationPush) {
        [self.js_animation_interaction attachToViewController:toVC];
    }
    self.js_animation_navigation.reverse = operation == UINavigationControllerOperationPop;
    return self.js_animation_navigation;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    return self.js_animation_interaction.transitionInProgress ? self.js_animation_interaction : nil;
}

- (void)dealloc {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
}

@end

#pragma mark - UIViewController+JSAnimation category

@implementation UIViewController (JSPAManager)

- (void)setJspaManager:(JSPAManager *)manager {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    manager.viewController = self;
    objc_setAssociatedObject(self, @selector(jspaManager), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JSPAManager *)jspaManager {
    if (jspa_debug) NSLog(@"%@ : %s", NSStringFromClass([self class]), __PRETTY_FUNCTION__);
    id jspaManager = objc_getAssociatedObject(self, @selector(jspaManager));
    if (!jspaManager) {
        if (jspa_debug) NSLog(@"Creating new %@", NSStringFromClass([self class]));
        jspaManager = [[JSPAManager alloc] init];
        self.jspaManager = jspaManager;
    }
    
    return jspaManager;
}

@end
