//
//  JSPAController.m
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSPAController.h"

@interface JSPAController ()
@end

@implementation JSPAController

- (instancetype)initWithController:(UIViewController *)controller {
    return [self initWithController:controller
         withPresentationTransition:JSPAAnimationPresentationDepth
            withDismissalTransition:JSPAAnimationDismissalDepth];
}

- (instancetype)initWithController:(UIViewController *)controller
        withPresentationTransition:(JSPAAnimationPresentation)presentation
           withDismissalTransition:(JSPAAnimationDismissal)dismissal {
    
    if (!(self = [super init])) return nil;

    NSAssert(presentation == JSPAAnimationPresentationDepth ||
             presentation == JSPAAnimationPresentationFromTop ||
             presentation == JSPAAnimationPresentationRotate, @"The Presentation Property must be set properly");
    NSAssert(dismissal == JSPAAnimationDismissalDepth ||
             dismissal == JSPAAnimationDismissalFromMiddle ||
             dismissal == JSPAAnimationDismissalRotate, @"The Dismissal Property must be set properly");
    
    _controller = controller;
    _controller.modalTransitionStyle = UIModalPresentationCustom;
    _controller.transitioningDelegate = _controller.jspaManager;
    [_controller.jspaManager setPresentation:presentation];
    [_controller.jspaManager setDismissal:dismissal];
    return self;
}

- (void)setDismissal:(JSPAAnimationDismissal)dismissal {
    _dismissal = dismissal;
    [self.controller.jspaManager setDismissal:_dismissal];
}

- (void)setPresentation:(JSPAAnimationPresentation)presentation {
    _presentation = presentation;
    [self.controller.jspaManager setPresentation:_presentation];
}

@end
