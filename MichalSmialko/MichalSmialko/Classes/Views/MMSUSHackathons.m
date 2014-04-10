//
//  MMSUSHackathons.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/10/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSUSHackathons.h"

@interface MMSUSHackathons ()
@property (nonatomic, strong) UIImageView *_mhacksLogoView;
@property (nonatomic, strong) UIImageView *_hackTechLogoView;
@end

@implementation MMSUSHackathons

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._mhacksLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mhacksLogo"]];
        [self._mhacksLogoView sizeToFit];
        [self addSubview:self._mhacksLogoView];
        
        self._hackTechLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hacktechLogo"]];
        [self._hackTechLogoView sizeToFit];
        [self addSubview:self._hackTechLogoView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self._mhacksLogoView.center = CGPointMake(self.frame.size.width/4.f,
                                              self.frame.size.height/2.f);
    self._hackTechLogoView.center = CGPointMake(self.frame.size.width/2.f + self.frame.size.width/4.,
                                                self.frame.size.height/2.f);
}

@end
