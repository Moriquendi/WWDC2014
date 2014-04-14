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
@property (nonatomic, strong) UIPageControl *_pageControl;
@property (nonatomic, strong, readwrite) MMSAGHacksView *aghacksView;
@property (nonatomic, strong, readwrite) MMSKrakJamView *krakJamView;
@property (nonatomic, strong, readwrite) MMSUSHackathonView *mhacksView;
@property (nonatomic, strong, readwrite) MMSUSHackathonView *hackTech;
@end

@implementation MMSHackathonsView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[MMSStyleSheet sharedInstance] tealColor];
        
        // Content view
        self._contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self._contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self._contentView.alwaysBounceHorizontal = YES;
        self._contentView.delegate = self;
        self._contentView.pagingEnabled = YES;
        [self addSubview:self._contentView];

        // KrakJam
        self.krakJamView = [[MMSKrakJamView alloc] init];
        [self._contentView addSubview:self.krakJamView];
        
        // MHacls
        self.mhacksView = [[MMSUSHackathonView alloc] init];
        self.mhacksView.detailsLabel.text = @"Hey ha. Bla bla, we attended MHacks and it \
        was awesome because  bla bla. We've made awesome hacks like SchedMe\
        which let you do lots of stuff, bla bla";
        self.mhacksView.logoView.image = [UIImage imageNamed:@"mhacksLogo"];
        self.mhacksView.stackViews = [self _mhacksImagesViews];
        [self._contentView addSubview:self.mhacksView];
        
        // HackTech
        self.hackTech = [[MMSUSHackathonView alloc] init];
        self.hackTech.detailsLabel.text = @"Hey ha. Bla bla, we attended HackTech and it \
        was awesome because  bla bla. We've made awesome hacks like SchedMe\
        which let you do lots of stuff, bla bla";
        self.hackTech.logoView.image = [UIImage imageNamed:@"hacktechLogo"];
        self.hackTech.backgroundColor = [UIColor colorWithRed:1. green:132./255. blue:0 alpha:1.0];
        self.hackTech.stackViews = [self _hackTechImageViews];
        [self._contentView addSubview:self.hackTech];
        
        // AGHacks
        self.aghacksView = [[MMSAGHacksView alloc] init];
        [self._contentView addSubview:self.aghacksView];
        
        // Page control
        self._pageControl = [[UIPageControl alloc] init];
        self._pageControl.numberOfPages = 8;
        [self._pageControl sizeToFit];
        self._pageControl.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        self._pageControl.currentPageIndicatorTintColor = [[MMSStyleSheet sharedInstance] redColor];
        [self addSubview:self._pageControl];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self._contentView.contentSize = CGSizeMake(self._contentView.frame.size.width * 8.f,
                                               self._contentView.frame.size.height);

    self.krakJamView.frame = self._contentView.bounds;
    self.mhacksView.frame = CGRectOffset(self.krakJamView.frame,
                                         self.krakJamView.frame.size.width,
                                         0);
    self.hackTech.frame = CGRectOffset(self.mhacksView.frame,
                                       self.mhacksView.frame.size.width * 2,
                                       0);
    self.aghacksView.frame = CGRectOffset(self.hackTech.frame,
                                          self.hackTech.frame.size.width * 2,
                                          0);
    
    self._pageControl.center = CGPointMake(CGRectGetMidX(self.bounds),
                                           self.frame.size.height - 50);
}

#pragma mark - MMSHackathonsView ()

- (NSArray *)_imageViewsWithName:(NSString *)name count:(NSInteger)count
{
    NSMutableArray *views = [NSMutableArray array];
    for (NSInteger i=0; i<count; i++) {
        NSString *imageName = [name stringByAppendingString:[NSString stringWithFormat:@"%li", i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(0, 0, 300, 300);
        [views addObject:imageView];
    }
    return [NSArray arrayWithArray:views];
}

- (NSArray *)_mhacksImagesViews
{
    return [self _imageViewsWithName:@"sched" count:2];
}

- (NSArray *)_hackTechImageViews
{
    return [self _imageViewsWithName:@"dare" count:2];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self._pageControl setCurrentPage:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > scrollView.frame.size.width &&
        scrollView.contentOffset.x < scrollView.frame.size.width * 3) {
        
        CGFloat delta = scrollView.contentOffset.x - scrollView.frame.size.width;
        self.mhacksView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                               delta,
                                                               0);
        self.mhacksView.contentView.contentOffset = CGPointMake(delta, 0);
        if (delta < scrollView.frame.size.width) {
            self.mhacksView.logoView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                                            delta*0.75, 0);
        }
    }
    else if (scrollView.contentOffset.x > scrollView.frame.size.width * 3 &&
             scrollView.contentOffset.x < scrollView.frame.size.width * 5) {
        CGFloat delta = scrollView.contentOffset.x - scrollView.frame.size.width * 3;
        self.hackTech.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                               delta,
                                                               0);
        self.hackTech.contentView.contentOffset = CGPointMake(delta, 0);
        if (delta < scrollView.frame.size.width) {
            self.hackTech.logoView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                                          delta*0.75, 0);
        }
    }
    else if (scrollView.contentOffset.x > scrollView.frame.size.width * 5 &&
        scrollView.contentOffset.x < scrollView.frame.size.width * 7) {
        CGFloat delta = scrollView.contentOffset.x - scrollView.frame.size.width * 5;
        self.aghacksView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                                delta,
                                                                0);
        self.aghacksView.contentView.contentOffset = CGPointMake(delta, 0);
    }
}

@end
