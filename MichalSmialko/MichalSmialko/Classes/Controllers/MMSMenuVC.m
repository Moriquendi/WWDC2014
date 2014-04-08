//
//  MMSMenuVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSMenuVC.h"
#import "MMSMenuView.h"

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
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self._menuView.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 400 + 100*idx);
        obj.alpha = 0.f;
        [UIView animateWithDuration:0.5 + 0.1*idx animations:^{
            obj.alpha = 1.f;
            obj.transform = CGAffineTransformIdentity;
        }];
    }];
}

#pragma mark - MMSMenuVC ()

- (void)_buttonTapped:(UIButton *)sender
{
    [self._menuView.buttons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        if (obj != sender) {
            // Explode
            [UIView animateWithDuration:0.3 animations:^{
                obj.alpha = 0.f;
            }];
        }
    }];
}

@end
