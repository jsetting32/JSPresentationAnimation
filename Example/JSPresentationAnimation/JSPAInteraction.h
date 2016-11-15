//
//  JSPAInteraction.h
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSPAInteraction : UIPercentDrivenInteractiveTransition
@property (weak, nonatomic) UINavigationController *navigationController;
@property (assign, nonatomic) BOOL shouldCompleteTransition;
@property (assign, nonatomic) BOOL transitionInProgress;
@property (assign, nonatomic) CGFloat completionSeed;
- (void)attachToViewController:(UIViewController *)viewController;
@end
