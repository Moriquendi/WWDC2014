//
//  MMSHackathonsView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSHackathonsView.h"
#import "MMSStyleSheet.h"

@interface MMSHackathonsView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *_contentView;
@property (nonatomic, strong, readwrite) MMSAGHacksView *aghacksView;
@property (nonatomic, strong, readwrite) MMSKrakJamView *krakJamView;
@property (nonatomic, strong, readwrite) MMSMHacksView *mhacksView;
@end

@implementation MMSHackathonsView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[MMSStyleSheet sharedInstance] redColor];
        
        self._contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self._contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self._contentView.alwaysBounceHorizontal = YES;
        self._contentView.delegate = self;
        self._contentView.pagingEnabled = YES;
        [self addSubview:self._contentView];

        // KrakJam
        self.krakJamView = [[MMSKrakJamView alloc] init];
        [self._contentView addSubview:self.krakJamView];
        
        // Hackathons
        self.mhacksView = [[MMSMHacksView alloc] init];
        [self._contentView addSubview:self.mhacksView];
        
        // AGHacks
        self.aghacksView = [[MMSAGHacksView alloc] init];
        [self._contentView addSubview:self.aghacksView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self._contentView.contentSize = CGSizeMake(self._contentView.frame.size.width * 6.f,
                                               self._contentView.frame.size.height);

    self.krakJamView.frame = self._contentView.bounds;
    self.mhacksView.frame = CGRectOffset(self.krakJamView.frame,
                                         self.krakJamView.frame.size.width,
                                         0);
    self.aghacksView.frame = CGRectOffset(self.mhacksView.frame,
                                          self.mhacksView.frame.size.width * 2,
                                          0);
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > scrollView.frame.size.width &&
        scrollView.contentOffset.x < scrollView.frame.size.width * 3) {
        CGFloat delta = scrollView.contentOffset.x - scrollView.frame.size.width;
        self.mhacksView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                               delta,
                                                               0);
        self.mhacksView.contentView.contentOffset = CGPointMake(delta, 0);
        self.mhacksView.mhacksLogoView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                                              delta*0.7, 0);
    }
    else if (scrollView.contentOffset.x > scrollView.frame.size.width * 3 &&
        scrollView.contentOffset.x < scrollView.frame.size.width * 5) {
        CGFloat delta = scrollView.contentOffset.x - scrollView.frame.size.width * 3;
        self.aghacksView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                                delta,
                                                                0);
        self.aghacksView.contentView.contentOffset = CGPointMake(delta, 0);
    }
}

@end
