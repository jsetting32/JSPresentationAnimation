//
//  JSPAViewController.m
//  JSPresentationAnimation
//
//  Created by John Setting on 11/13/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSPAViewController.h"
#import "JSPAController.h"
#import "JSPAPresentedController.h"

@interface JSPAViewController ()

@end

@implementation JSPAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (IBAction)didTapButton:(id)sender {
    JSPAPresentedController *root = [[JSPAPresentedController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    JSPAController *controller = [[JSPAController alloc] initWithController:nav];
    [self presentViewController:[controller controller] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
