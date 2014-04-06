//
//  MMSHelloView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSHelloView.h"

@interface MMSHelloView ()
@property (nonatomic, strong) UILabel *helloLabel;
@end

@implementation MMSHelloView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.helloLabel = [[UILabel alloc] init];
        self.helloLabel.text = @"Hello...";
        [self.helloLabel sizeToFit];
        self.helloLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:self.helloLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.helloLabel.frame = CGRectMake(0,
                                       self.frame.size.height/2.f - self.helloLabel.frame.size.height/2.f,
                                       self.helloLabel.frame.size.width,
                                       self.helloLabel.frame.size.height);
}

@end
