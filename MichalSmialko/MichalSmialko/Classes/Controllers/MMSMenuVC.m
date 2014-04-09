//
//  MMSMenuVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSMenuVC.h"
#import "MMSMenuView.h"
#import "MMSHackathonsVC.h"

@interface MMSMenuVC ()
@property (nonatomic, strong) MMSMenuView *_menuView;
@end

@implementation MMSMenuVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._menuView = [[MMSMenuView alloc] initWithFrame:self.view.bounds];
    self._menuView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self._menuView];
    
    [self._menuView.buttons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.tag = idx;
        [obj addTarget:self action:@selector(_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }];

    [self._menuView.buttons[0] setTitle:@"My Projects" forState:UIControlStateNormal];
    [self._menuView.buttons[1] setTitle:@"Hackathons" forState:UIControlStateNormal];
    [self._menuView.buttons[2] setTitle:@"Learn & Teach" forState:UIControlStateNormal];
    [self._menuView.buttons[3] setTitle:@"Work & Study" forState:UIControlStateNormal];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self._menuView.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 400 + 100*idx);
        obj.transform = CGAffineTransformScale(obj.transform, 1./100., 1./100.);
        obj.alpha = 0.f;
        [UIView animateWithDuration:0.4 + 0.1*idx animations:^{
            obj.alpha = 1.f;
            obj.transform = CGAffineTransformIdentity;
        }];
    }];
}

#pragma mark - MMSMenuVC ()

- (void)_buttonTapped:(UIButton *)sender
{
    NSArray *VCClasses = @[[MMSHackathonsVC class],
                           [MMSHackathonsVC class],
                           [MMSHackathonsVC class],
                           [MMSHackathonsVC class]];
    
    [self._menuView animateButtonSelection:sender complection:^{
        UIViewController *vc = [[VCClasses[sender.tag] alloc] init];
        [vc willMoveToParentViewController:self];
        vc.view.frame = self.view.bounds;
        [self.view addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }];
}

@end
