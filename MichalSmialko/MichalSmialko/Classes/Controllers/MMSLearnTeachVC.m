//
//  MMSLearnTeachVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/10/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSLearnTeachVC.h"
#import "MMSLearnTeachView.h"

@interface MMSLearnTeachVC ()
@property (nonatomic, strong) MMSLearnTeachView *_learnTeachView;
@end

@implementation MMSLearnTeachVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self._learnTeachView = [[MMSLearnTeachView alloc] initWithFrame:self.view.bounds];
    self._learnTeachView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self._learnTeachView];
}

@end
