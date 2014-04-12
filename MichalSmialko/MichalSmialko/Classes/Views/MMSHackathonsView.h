//
//  MMSHackathonsView.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSAGHacksView.h"
#import "MMSKrakJamView.h"
#import "MMSMHacksView.h"

@interface MMSHackathonsView : UIView

@property (nonatomic, strong, readonly) MMSAGHacksView *aghacksView;
@property (nonatomic, strong, readonly) MMSKrakJamView *krakJamView;
@property (nonatomic, strong, readonly) MMSMHacksView *mhacksView;

@end
