//
//  MMSLearnTeachView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/11/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSLearnTeachView.h"

@interface MMSLearnTeachView ()
@property (nonatomic, strong) UIScrollView *_contentScrollView;
@property (nonatomic, strong, readwrite) MMSCocoaHeadsView *cocoaHeadsView;
@property (nonatomic, strong, readwrite) MMSEventsView *eventsView;
@property (nonatomic, strong, readwrite) UIButton *nextButton;
@property (nonatomic, strong, readwrite) UIButton *previousButton;
@end

@implementation MMSLearnTeachView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Content Scroll View
        self._contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:self._contentScrollView];
        
        // Cocoa Heads
        self.cocoaHeadsView = [[MMSCocoaHeadsView alloc] init];
        [self._contentScrollView addSubview:self.cocoaHeadsView];
        
        // Events
        self.eventsView = [[[NSBundle mainBundle] loadNibNamed:@"MMSEventsView"
                                                         owner:self
                                                       options:nil] objectAtIndex:0];
        [self._contentScrollView addSubview:self.eventsView];
        
        // Conferences
        // WWDC
        
        // Next button
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nextButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [self.nextButton sizeToFit];
        [self.nextButton addTarget:self action:@selector(_nextPage:) forControlEvents:UIControlEventTouchUpInside];
        [self._contentScrollView addSubview:self.nextButton];
        
        self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.previousButton setImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
        [self.previousButton sizeToFit];
        [self.previousButton addTarget:self action:@selector(_previousPage:) forControlEvents:UIControlEventTouchUpInside];
        [self._contentScrollView addSubview:self.previousButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self._contentScrollView.frame = self.bounds;
    self.cocoaHeadsView.frame = self._contentScrollView.bounds;
    self.eventsView.frame = CGRectOffset(self.cocoaHeadsView.frame,
                                         self.cocoaHeadsView.frame.size.width,
                                         0);
    
    self.nextButton.center = CGPointMake(self._contentScrollView.frame.size.width - 60,
                                         CGRectGetMidY(self._contentScrollView.bounds));
    self.previousButton.center = CGPointMake(self._contentScrollView.frame.size.width + 60,
                                             self.nextButton.center.y);
}

#pragma mark - MMSLearnTeachView ()

- (void)_nextPage:(UIButton *)sender
{
    [UIView animateWithDuration:0.6
                     animations:^{
                         self._contentScrollView.contentOffset = CGPointMake(self._contentScrollView.contentOffset.x +
                                                                             self._contentScrollView.frame.size.width,
                                                                             0);
                     }];
}

- (void)_previousPage:(UIButton *)sender
{
    [UIView animateWithDuration:0.6
                     animations:^{
                         self._contentScrollView.contentOffset = CGPointMake(0, 0);
                     }];
}

@end
