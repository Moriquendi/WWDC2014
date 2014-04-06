//
//  MMSViewController.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSHelloViewController.h"
#import "MMSHelloView.h"

@interface MMSHelloViewController ()
@property (nonatomic, strong) MMSHelloView *_helloView;
@end

@implementation MMSHelloViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._helloView = [[MMSHelloView alloc] initWithFrame:self.view.bounds];
    self._helloView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self._helloView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self._helloView performSelector:@selector(startAnimation) withObject:nil afterDelay:1.0];
    [self._helloView startAnimation];
}

@end
