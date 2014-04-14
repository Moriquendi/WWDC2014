//
//  MMSAboutMeView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/13/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSAboutMeView.h"

@interface MMSAboutMeView ()
@property (nonatomic, strong, readwrite) UIScrollView *contentView;
@property (nonatomic, strong, readwrite) MMSPolandView *polandView;
@end

@implementation MMSAboutMeView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView = [[UIScrollView alloc] init];
        self.contentView.alwaysBounceVertical = YES;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.contentView];

        self.polandView = [[[NSBundle mainBundle] loadNibNamed:@"MMSPolandView"
                                                         owner:self
                                                       options:nil] objectAtIndex:0];
        [self.contentView addSubview:self.polandView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.polandView sizeToFit];
    self.polandView.frame = CGRectMake(0,
                                       0,
                                       self.contentView.frame.size.width,
                                       self.polandView.frame.size.height);
    
    self.contentView.frame = self.bounds;
    self.contentView.contentSize = CGSizeMake(self.contentView.frame.size.width,
                                               self.polandView.frame.size.height);
}

@end
