//
//  MMSUSHackathons.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/10/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSUSHackathonView.h"

@interface MMSUSHackathonView ()
@property (nonatomic, strong, readwrite) UIScrollView *contentView;
@property (nonatomic, strong, readwrite) UIImageView *logoView;
@property (nonatomic, strong, readwrite) UILabel *detailsLabel;
@end

@implementation MMSUSHackathonView

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
        self.logoView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.logoView];
        
        // Details
        self.detailsLabel = [[UILabel alloc] init];
        self.detailsLabel.numberOfLines = 0;
        self.detailsLabel.textColor = [UIColor whiteColor];
        self.detailsLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.detailsLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    self.contentView.contentSize = CGSizeMake(self.frame.size.width * 2,
                                              self.frame.size.height);
    
    [self.logoView sizeToFit];
    self.logoView.center = CGPointMake(self.contentView.frame.size.width/2.f,
                                       self.contentView.frame.size.height/2.f);
    
    self.detailsLabel.frame = CGRectMake(self.contentView.frame.size.width +
                                         self.contentView.frame.size.width / 2.f - 50,
                                         self.contentView.frame.size.height/2.f - 100,
                                         300,
                                         200);
}

@end
