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
#import "MMSProjectsVC.h"
#import "MMSLearnTeachVC.h"
#import "MMSAboutMeVC.h"

@interface MMSMenuVC ()
@property (nonatomic, strong) UIViewController *_visibleVC;
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
    
    NSArray *titles = @[@"About Me",
                        @"My Projects",
                        @"Hackathons",
                        @"Learn & Teach"];
    
    [self._menuView.buttons enumerateObjectsUsingBlock:^(MMSCubeButton *obj, NSUInteger idx, BOOL *stop) {
        obj.tag = idx;
        [obj addTarget:self action:@selector(_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        obj.largeTitleLabel.text = titles[idx];
    }];
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
    NSArray *VCClasses = @[[MMSAboutMeVC class],
                           [MMSProjectsVC class],
                           [MMSHackathonsVC class],
                           [MMSLearnTeachVC class]];
    
    [self._menuView animateButtonSelection:sender complection:^{
        self._visibleVC = [[VCClasses[sender.tag] alloc] init];
        [self._visibleVC willMoveToParentViewController:self];
        self._visibleVC.view.frame = self.view.bounds;
        self._visibleVC.view.alpha = 0.f;
        [self.view addSubview:self._visibleVC.view];
        [self addChildViewController:self._visibleVC];
        [self._visibleVC didMoveToParentViewController:self];
        
        [UIView animateWithDuration:0.5 animations:^{
            self._visibleVC.view.alpha = 1.f;
        }];
        
        UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [dismissButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [dismissButton sizeToFit];
        dismissButton.frame = CGRectOffset(dismissButton.frame, 30, 40);
        [self._visibleVC.view addSubview:dismissButton];
        [dismissButton addTarget:self
                          action:@selector(_dismissButtonTapped:)
                forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)_dismissButtonTapped:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self._visibleVC.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self._visibleVC.view removeFromSuperview];
        self._visibleVC = nil;
        
        [self._menuView animateButtonAppearanceComplection:^{
            
        }];
    }];
}

@end
