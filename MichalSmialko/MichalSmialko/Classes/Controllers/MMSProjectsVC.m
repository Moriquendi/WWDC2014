//
//  MMSProjectsVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSProjectsVC.h"
#import "MMSCubesMenu.h"

@interface MMSProjectsVC ()

@end

@implementation MMSProjectsVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Menu
    MMSCubesMenu *menu = [[MMSCubesMenu alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.frame.size.height)
                                                buttonsCount:4];
    menu.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [menu.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.tag = idx;
        [btn addTarget:self action:@selector(_menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self.view addSubview:menu];
}

#pragma mark- MMSProjectsVC ()

- (void)_menuButtonSelected:(UIButton *)sender
{
    
}

@end
