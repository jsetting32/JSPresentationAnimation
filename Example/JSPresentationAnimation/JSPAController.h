//
//  JSPAController.h
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSPresentationAnimation.h"

@interface JSPAController : NSObject
@property (assign, nonatomic) JSPAAnimationPresentation presentation;
@property (assign, nonatomic) JSPAAnimationDismissal dismissal;
@property (weak, nonatomic) UIViewController *controller;
- (instancetype)initWithController:(UIViewController *)controller;
- (instancetype)initWithController:(UIViewController *)controller
        withPresentationTransition:(JSPAAnimationPresentation)presentation
           withDismissalTransition:(JSPAAnimationDismissal)dismissal;
@end
