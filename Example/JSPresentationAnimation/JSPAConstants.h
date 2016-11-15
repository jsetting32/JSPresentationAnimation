//
//  JSAnimationConstants.h
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* 
 *
 * Presentation Animation ENUMs
 * ----------------------------------
 *
 * JSAnimationPresentationScaleBehind
 * - This animation will first push the current view controller back making a depth animation then present the modal view controller from the bottom up
 * ----------------------------------
 * 
 * JSAnimationPresentationFromTop
 * - This animation will present the modal view controller from the top of the window rather from the bottom
 * ----------------------------------
 *
 * JSAnimationPresentationRotate (BETA)
 * - This animation will present the modal controller rotating from the top right corner of the window
 * ----------------------------------
 *
 *
 *
 * Dismissal Animation ENUMs
 * ----------------------------------
 *
 * JSAnimationDismissalScaleBehind
 * - This animation is the opposite of JSAnimationPresentationScaleBehind. It will dismiss the current view controller to the 
 * bottom of the screen and simultaneously bring the root controller towards the window (depth perception)
 * ----------------------------------
 *
 * JSAniamtionDismissalScaleDownMiddle
 * - This animation will dismiss the presented controller by scaling it to 0 towards the middle of the screen, with an animation duration
 * ----------------------------------
 *
 * JSAnimationDismissalRotate (BETA)
 * - This animation will dismiss the modal controller rotating from the top right corner of the window
 * ----------------------------------
 *
 **/

typedef NS_ENUM(NSUInteger, JSPAAnimationPresentation) {
    JSPAAnimationPresentationDepth      = 1 << 0,
    JSPAAnimationPresentationFromTop    = 1 << 1,
    JSPAAnimationPresentationRotate
};

typedef NS_ENUM(NSUInteger, JSPAAnimationDismissal) {
    JSPAAnimationDismissalDepth         = 1 << 0,
    JSPAAnimationDismissalFromMiddle    = 1 << 1,
    JSPAAnimationDismissalRotate
};

extern BOOL const jspa_debug;

extern CGFloat const jspa_animation_presentation_duration;
extern CGFloat const jspa_animation_presentation_spring_delay;
extern CGFloat const jspa_animation_presentation_spring_damping;
extern CGFloat const jspa_animation_presentation_spring_velocity;
extern UIViewAnimationOptions const jspa_animation_presentation_spring_option;

extern CGFloat const jspa_animation_dismissal_duration;
extern CGFloat const jspa_animation_dismissal_spring_delay;
extern CGFloat const jspa_animation_dismissal_spring_damping;
extern CGFloat const jspa_animation_dismissal_spring_velocity;
extern UIViewAnimationOptions const jspa_animation_dismissal_spring_option;

extern CGFloat const jspa_animation_navigation_duration;
extern CGFloat const jspa_animation_navigation_spring_delay;
extern CGFloat const jspa_animation_navigation_spring_damping;
extern CGFloat const jspa_animation_navigation_spring_velocity;
extern UIViewAnimationOptions const jspa_animation_navigation_spring_option;

