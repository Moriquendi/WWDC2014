//
//  MMSKaratePandaView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSKaratePandaView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MMSStyleSheet.h"

@interface MMSKaratePandaView ()
@property (weak, nonatomic) IBOutlet UILabel *_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *_detailsLabel;
@property (weak, nonatomic) IBOutlet UIView *_videoContentView;
@property (weak, nonatomic) IBOutlet UIImageView *_img1;
@property (weak, nonatomic) IBOutlet UIImageView *_img2;
@property (weak, nonatomic) IBOutlet UIImageView *_img3;
@property (weak, nonatomic) IBOutlet UIImageView *_img4;
@property (nonatomic, strong) MPMoviePlayerController *_moviePlayerController;
@end

@implementation MMSKaratePandaView

#pragma mark - UIView

- (void)awakeFromNib
{
    
    self.backgroundColor = [[MMSStyleSheet sharedInstance] tealColor];
    
    // Movie
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"KaratePandaTrailer" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    self._moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self._moviePlayerController prepareToPlay];
    self._moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    self._moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
    self._moviePlayerController.view.frame = self._videoContentView.bounds;
    [self._videoContentView addSubview:self._moviePlayerController.view];
    
    //
    self._titleLabel.textColor = [UIColor whiteColor];
    self._detailsLabel.textColor = [UIColor whiteColor];
    
    //
    [self _restyleImage:self._img1];
    [self _restyleImage:self._img2];
    [self _restyleImage:self._img3];
    [self _restyleImage:self._img4];
    
    self._img1.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4/5);
    self._img2.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4/5);
    self._img3.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4/5);
    self._img4.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4/5);
}

- (void)_restyleImage:(UIView *)view
{
    view.layer.borderColor = [[UIColor whiteColor] CGColor];
    view.layer.borderWidth = 6;
}

@end
