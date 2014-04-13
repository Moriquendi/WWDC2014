//
//  MMSAboutMeView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/13/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSAboutMeView.h"

@interface MMSAboutMeView ()
@property (nonatomic, strong) UIScrollView *_contentView;
@property (nonatomic, strong, readwrite) MMSPolandView *polandView;
@end

@implementation MMSAboutMeView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._contentView = [[UIScrollView alloc] init];
        self._contentView.alwaysBounceVertical = YES;
        self._contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self._contentView];

        self.polandView = [[[NSBundle mainBundle] loadNibNamed:@"MMSPolandView"
                                                         owner:self
                                                       options:nil] objectAtIndex:0];
        [self._contentView addSubview:self.polandView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.polandView sizeToFit];
    self.polandView.frame = CGRectMake(0,
                                       0,
                                       self._contentView.frame.size.width,
                                       self.polandView.frame.size.height);
    
    self._contentView.frame = self.bounds;
    self._contentView.contentSize = CGSizeMake(self._contentView.frame.size.width,
                                               self.polandView.frame.size.height);
}

@end
