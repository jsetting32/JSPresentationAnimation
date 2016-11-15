//
//  JSPAManager.h
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSPresentationAnimation.h"

@interface JSPAManager : NSObject <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic, readonly) UIViewController *viewController;
- (void)setDismissal:(JSPAAnimationDismissal)dismissal;
- (void)setPresentation:(JSPAAnimationPresentation)presentation;
@end


@interface UIViewController (JSPAManager)
/* Initially, this is nil, but created for you when you access it */
@property (strong, nonatomic) JSPAManager *jspaManager;
@end
