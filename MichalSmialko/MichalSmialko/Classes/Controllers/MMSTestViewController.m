//
//  MMSTestViewController.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/7/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSTestViewController.h"
#import "MMSStackView.h"

@interface MMSTestViewController ()

@end

@implementation MMSTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *stackViews = [NSMutableArray array];
    for (NSInteger i=0; i<5; i++) {
        UIView *newView = [[UIView alloc] init];
        newView.backgroundColor = [UIColor colorWithRed:(30*i)/255.
                                                  green:(0*i)/255.
                                                   blue:(0*i)/255. alpha:1.0];
        [stackViews addObject:newView];
    }
    
    MMSStackView *stack = [[MMSStackView alloc] initWithViews:stackViews
                                                        frame:CGRectMake(100, 100,
                                                                         300, 300)];
    [self.view addSubview:stack];
}

@end
