//
//  MMSKrakJamView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSKrakJamView.h"
#import "MMSStyleSheet.h"
#import "MMSStackView.h"

@interface MMSKrakJamView ()
@property (nonatomic, strong) UIImageView *_logoView;
@property (nonatomic, strong) UILabel *_detailsLabel;
@end

@implementation MMSKrakJamView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[MMSStyleSheet sharedInstance] tealColor];
        
        // Logo
        self._logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ggj"]];
        [self._logoView sizeToFit];
        [self addSubview:self._logoView];
        
        // Details
        self._detailsLabel = [[UILabel alloc] init];
        self._detailsLabel.text = @"Four years ago, I attended my first 48-hours hackathon - Global Game Jam. Back then, me and my friends knew almost nothing about programming. Even though, we've managed to finish simple and funny iOS game.";
        self._detailsLabel.backgroundColor = [UIColor clearColor];
        self._detailsLabel.textColor = [UIColor whiteColor];
        self._detailsLabel.font = [UIFont systemFontOfSize:22.];
        self._detailsLabel.numberOfLines = 0;
        [self addSubview:self._detailsLabel];

        //
        UIImageView *photoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"krakjam"]];
        photoView.center = CGPointMake(300, 350);
        [photoView sizeToFit];
        [self addSubview:photoView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self._logoView.center = CGPointMake(self.frame.size.width - self.frame.size.width/4.,
                                        self.frame.size.height/4);
    
    self._detailsLabel.frame = CGRectMake(self.frame.size.width - 450,
                                          self.frame.size.height/2.f - 30,
                                          350,
                                          300);
}

@end
