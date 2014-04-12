//
//  MMSProjectsVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSProjectsVC.h"
#import "MMSCubesMenu.h"
#import "MMSFarmView.h"
#import "MMSKaratePandaView.h"
#import "MMSSmartTapsView.h"
#import "MMSBaseView.h"
#import "MMSBurglarsNightView.h"

@interface MMSProjectsVC ()
@property (nonatomic, strong) UIView *_sideView;
@property (nonatomic, strong) UIView *_contentView;
@property (nonatomic, strong) MMSCubesMenu *_menu;
@end

@implementation MMSProjectsVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Content
    self._contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self._contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self._contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self._contentView];
    
    // Side view
    self._sideView = [[UIView alloc] initWithFrame:CGRectMake(200,
                                                              0,
                                                              self._contentView.frame.size.width - 200,
                                                              self._contentView.frame.size.height)];
    self._sideView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    [self._contentView addSubview:self._sideView];
    
    // Menu
    self._menu = [[MMSCubesMenu alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                200,
                                                                self.view.frame.size.height)
                                        buttonsCount:6];
    self._menu.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    NSArray *titles = @[@"Farm 2",
                        @"Karate Panda",
                        @"Smart Taps",
                        @"Base",
                        @"Burglars Night", @"", @"", @""];
    [self._menu.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.tag = idx;
        [btn addTarget:self action:@selector(_menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titles[idx] forState:UIControlStateNormal];
    }];
    [self._contentView addSubview:self._menu];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self._menu animateButtonsAppearance];
}

#pragma mark- MMSProjectsVC ()

- (void)_menuButtonSelected:(UIButton *)sender
{
    // Remove old view
    [[self._sideView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    // Add new one
    UIView *addedView;
    switch (sender.tag) {
        case 0: {
            MMSFarmView *farmView = [[[NSBundle mainBundle] loadNibNamed:@"MMSFarmView"
                                                                   owner:self
                                                                 options:nil] objectAtIndex:0];
            addedView = farmView;
        }
            break;
        case 1: {
            MMSKaratePandaView *pandaView = [[MMSKaratePandaView alloc] initWithFrame:self._sideView.bounds];
            addedView = pandaView;
        }
            break;
        case 2: {
            MMSSmartTapsView *tapsView = [[[NSBundle mainBundle] loadNibNamed:@"MMSSmartTapsView"
                                                                        owner:self
                                                                      options:nil] objectAtIndex:0];
            addedView = tapsView;
        }
        case 3: {
            // Base
            MMSBaseView *baseView = [[[NSBundle mainBundle] loadNibNamed:@"MMSBaseView"
                                                                   owner:self
                                                                 options:nil] objectAtIndex:0];
            addedView = baseView;
        }
        case 4: {
            // WhosAt
        }
        case 5: {
            // Chay
        }
        case 6: {
            // Burglars Night
            MMSBurglarsNightView *burglarsView = [[[NSBundle mainBundle] loadNibNamed:@"MMSBurglarsNightView"
                                                                   owner:self
                                                                 options:nil] objectAtIndex:0];
            addedView = burglarsView;
        }
            break;
    }
    
    addedView.frame = self._sideView.bounds;
    [self._sideView addSubview:addedView];
}

@end
