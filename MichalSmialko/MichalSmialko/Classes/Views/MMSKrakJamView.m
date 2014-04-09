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
        
        UIImageView *photoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"krakjam"]];
        [photoView sizeToFit];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AGHacksPromo" ofType:@"mov"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        self._moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
        [self._moviePlayerController prepareToPlay];
        self._moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
        self._moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
        self._moviePlayerController.view.frame = self.bounds;
        self._moviePlayerController.view.userInteractionEnabled = NO;
        self._moviePlayerController.repeatMode = MPMovieRepeatModeOne;
        
        photoView.userInteractionEnabled = YES;
        self._moviePlayerController.view.userInteractionEnabled = YES;
        self._stackView = [[MMSStackView alloc] initWithViews:@[photoView,
                                                                self._moviePlayerController.view]
                                                        frame:CGRectMake(80, 200, 300, 300)];
        
        
        
        [self addSubview:self._stackView];
    }
    return self;
}

@end
