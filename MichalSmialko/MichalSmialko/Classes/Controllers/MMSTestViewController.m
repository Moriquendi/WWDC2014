//
//  MMSTestViewController.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/7/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSTestViewController.h"
#import "MMSCocoaHeadsView.h"

@interface MMSTestViewController ()

@end

@implementation MMSTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MMSCocoaHeadsView *chView = [[MMSCocoaHeadsView alloc] initWithFrame:self.view.bounds];
    chView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:chView];
}

@end
