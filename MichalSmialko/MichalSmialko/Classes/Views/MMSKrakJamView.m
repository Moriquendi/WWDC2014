//
//  MMSKrakJamView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSKrakJamView.h"
#import "MMSStyleSheet.h"

@implementation MMSKrakJamView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[MMSStyleSheet sharedInstance] tealColor];
    }
    return self;
}

@end
