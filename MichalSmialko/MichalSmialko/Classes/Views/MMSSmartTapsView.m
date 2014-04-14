//
//  MMSSmartTapsView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSSmartTapsView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MMSStyleSheet.h"

@interface MMSSmartTapsView ()
@property (weak, nonatomic) IBOutlet UIView *_videoContentView;
@property (nonatomic, strong) MPMoviePlayerController *_moviePlayerController;
@property (weak, nonatomic) IBOutlet UILabel *_detailsLabel;

@end

@implementation MMSSmartTapsView

#pragma mark - UIView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [[MMSStyleSheet sharedInstance] yellowColor];
    
    // Movie
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SmartCatchPromo" ofType:@"m4v"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    self._moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self._moviePlayerController prepareToPlay];
    self._moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    self._moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
    self._moviePlayerController.view.frame = self._videoContentView.bounds;
    [self._videoContentView addSubview:self._moviePlayerController.view];
    
    // Label
    self._detailsLabel.textColor = [UIColor whiteColor];
}

@end
