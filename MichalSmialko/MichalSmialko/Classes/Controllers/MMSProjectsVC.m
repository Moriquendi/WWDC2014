//
//  MMSProjectsVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSProjectsVC.h"
#import "MMSCubeView.h"

@interface MMSProjectsVC ()

@end

@implementation MMSProjectsVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MMSCubeView *view = [[MMSCubeView alloc] initWithFrame:CGRectMake(300, 300, 300, 300)];
    [self.view addSubview:view];
}

@end
