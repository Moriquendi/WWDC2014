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

@interface MMSProjectsVC ()
@property (nonatomic, strong) UIView *_sideView;
@property (nonatomic, strong) UIView *_contentView;
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
    MMSCubesMenu *menu = [[MMSCubesMenu alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        200,
                                                                        self.view.frame.size.height)
                                                buttonsCount:4];
    menu.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [menu.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.tag = idx;
        [btn addTarget:self action:@selector(_menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self._contentView addSubview:menu];
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
            // Smart Taps
        }
        case 3: {
            // Base ?
        }
        case 4: {
            // WhosAt
        }
        case 5: {
            // Chayamuni
        }
        case 6: {
            // Burglars Night
        }
            break;
    }
    
    addedView.frame = self._sideView.bounds;
    [self._sideView addSubview:addedView];
}

@end
