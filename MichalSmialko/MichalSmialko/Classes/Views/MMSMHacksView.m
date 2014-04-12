//
//  MMSUSHackathons.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/10/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSMHacksView.h"

@interface MMSMHacksView ()
@property (nonatomic, strong, readwrite) UIScrollView *contentView;
@property (nonatomic, strong, readwrite) UIImageView *mhacksLogoView;
@property (nonatomic, strong) UILabel *_detailsLabel;
@end

@implementation MMSMHacksView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Scroll view
        self.contentView = [[UIScrollView alloc] init];
        self.contentView.pagingEnabled = YES;
        self.contentView.scrollEnabled = NO;
        [self addSubview:self.contentView];
        
        // Logo
        self.mhacksLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mhacksLogo"]];
        [self.mhacksLogoView sizeToFit];
        [self.contentView addSubview:self.mhacksLogoView];
        
        // Details
        self._detailsLabel = [[UILabel alloc] init];
        self._detailsLabel.numberOfLines = 0;
        self._detailsLabel.textColor = [UIColor whiteColor];
        self._detailsLabel.font = [UIFont systemFontOfSize:20];
        self._detailsLabel.text = @"Hey ha. Bla bla, we attended MHacks and it \
        was awesome because  bla bla. We've made awesome hacks like SchedMe\
        which let you do lots of stuff, bla bla";
        [self.contentView addSubview:self._detailsLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    self.contentView.contentSize = CGSizeMake(self.frame.size.width * 2,
                                              self.frame.size.height);
    
    self.mhacksLogoView.center = CGPointMake(self.contentView.frame.size.width/2.f,
                                             self.contentView.frame.size.height/2.f);
    
    self._detailsLabel.frame = CGRectMake(self.contentView.frame.size.width +
                                          self.contentView.frame.size.width / 2.f -
                                          150,
                                          self.contentView.frame.size.height/2.f - 100,
                                          300,
                                          200);
}

@end
