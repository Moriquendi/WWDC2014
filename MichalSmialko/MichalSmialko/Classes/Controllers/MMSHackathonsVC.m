//
//  MMSHackathonsVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSHackathonsVC.h"
#import "MMSHackathonsView.h"

@interface MMSHackathonsVC ()
@property (nonatomic, strong) MMSHackathonsView *_hackathonsView;
@end

@implementation MMSHackathonsVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self._hackathonsView = [[MMSHackathonsView alloc] initWithFrame:self.view.bounds];
    self._hackathonsView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self._hackathonsView];
}

@end
