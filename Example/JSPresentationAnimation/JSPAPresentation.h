//
//  JSPAPresentation.h
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JSPresentationAnimation.h"

@interface JSPAPresentation : NSObject <UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) JSPAAnimationPresentation presentation;
@end
