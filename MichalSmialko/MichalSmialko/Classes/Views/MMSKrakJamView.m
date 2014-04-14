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
#import <MediaPlayer/MediaPlayer.h>

@interface MMSKrakJamView ()
@property (nonatomic, strong) UIImageView *_logoView;
@property (nonatomic, strong) UILabel *_detailsLabel;
@property (nonatomic, strong) MMSStackView *_stackView;
@property (nonatomic, strong) MPMoviePlayerController *_moviePlayerController;
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
        [photoView sizeToFit];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"KrakJamTrailer" ofType:@"m4v"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        self._moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
        self._moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
        self._moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
        self._moviePlayerController.view.frame = self.bounds;
        self._moviePlayerController.view.userInteractionEnabled = NO;
        self._moviePlayerController.repeatMode = MPMovieRepeatModeOne;
        self._moviePlayerController.view.frame = CGRectMake(0, 0, 300, 200);
        
        photoView.userInteractionEnabled = YES;
        self._moviePlayerController.view.userInteractionEnabled = YES;
        
        self._stackView = [[MMSStackView alloc] initWithViews:@[self._moviePlayerController.view,
                                                                photoView]
                                                        anchorPoint:CGPointMake(300,
                                                                                400)];
        [self addSubview:self._stackView];
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
    
    self._stackView.frame = self.bounds;
}

@end
