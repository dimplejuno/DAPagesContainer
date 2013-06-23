//
//  DAViewController.m
//  DAPagesContainerDemo
//
//  Created by Daria Kopaliani on 5/30/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAViewController.h"

#import "DAPagesContainer.h"
#import "SPDDynamicDropMenuViewController.h"


@interface DAViewController ()

@property (strong, nonatomic) DAPagesContainer *pagesContainer;

@end


@implementation DAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"\"너의 목소리가 들려\"";
    
    self.pagesContainer = [[DAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = self.view.bounds;
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pagesContainer.view];
    [self.pagesContainer didMoveToParentViewController:self];
    
    SPDDynamicDropMenuViewController *beaverViewController = [[SPDDynamicDropMenuViewController alloc] init];
    beaverViewController.menuImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LBY"]];
    beaverViewController.title = @"이보영";
    
    
    SPDDynamicDropMenuViewController *buckDeerViewController = [[SPDDynamicDropMenuViewController alloc] init];
    buckDeerViewController.menuImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LJS"]];
    buckDeerViewController.title = @"이종석";
    
    SPDDynamicDropMenuViewController *catViewController = [[SPDDynamicDropMenuViewController alloc] init];
    catViewController.menuImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YSH"]];
    catViewController.title = @"윤상현";
    
    SPDDynamicDropMenuViewController *lionViewController = [[SPDDynamicDropMenuViewController alloc] init];
    lionViewController.menuImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LDH"]];
    lionViewController.title = @"이다희";
    self.pagesContainer.viewControllers = @[beaverViewController, buckDeerViewController, catViewController, lionViewController];
}

- (void)viewWillUnload
{
    self.pagesContainer = nil;
    [super viewWillUnload];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.pagesContainer updateLayoutForNewOrientation:toInterfaceOrientation];
}

@end