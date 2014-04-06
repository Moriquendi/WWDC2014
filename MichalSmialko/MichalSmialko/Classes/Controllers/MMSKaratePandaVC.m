//
//  MMSKaratePandaVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSKaratePandaVC.h"
#import "MMSKaratePandaView.h"

@interface MMSKaratePandaVC ()
@property (nonatomic, strong) MMSKaratePandaView *_gameView;
@end

@implementation MMSKaratePandaVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._gameView = [[MMSKaratePandaView alloc] initWithFrame:CGRectInset(self.view.bounds, 100, 100)];
    self._gameView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self._gameView];
}

@end
