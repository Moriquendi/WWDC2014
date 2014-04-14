//
//  MMSFarmView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSFarmView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MMSStackView.h"
#import "MMSStyleSheet.h"

@interface MMSFarmView ()
@property (weak, nonatomic) IBOutlet UILabel *_titleLabel;
@property (weak, nonatomic) IBOutlet UIView *_videoContentView;
@property (weak, nonatomic) IBOutlet UILabel *_detailsLabel;
@property (nonatomic, strong) MPMoviePlayerController *_moviePlayerController;
@property (nonatomic, strong) MMSStackView *_stack;
@end

@implementation MMSFarmView

#pragma mark - UIView

- (void)awakeFromNib
{
    self.backgroundColor = [[MMSStyleSheet sharedInstance] darkRedColor];
    
    self._titleLabel.textColor = [UIColor whiteColor];
    self._detailsLabel.textColor = [UIColor whiteColor];

    // Movie
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"farmvid" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    self._moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self._moviePlayerController prepareToPlay];
    self._moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    self._moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
    self._moviePlayerController.view.frame = self._videoContentView.bounds;
    self._moviePlayerController.view.layer.borderColor = [[UIColor whiteColor] CGColor];
    self._moviePlayerController.view.layer.borderWidth = 6;
    [self._videoContentView addSubview:self._moviePlayerController.view];
    
    // Stack
    NSMutableArray *imgs = [NSMutableArray array];
    for (NSInteger i=0; i<2; i++) {
        NSString *imgName = [@"farm" stringByAppendingString:[NSString stringWithFormat:@"%li", i+1]];
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.frame = CGRectMake(0, 0, 200, 200);
        img.userInteractionEnabled = YES;
        [imgs addObject:img];
    }
    self._stack = [[MMSStackView alloc] initWithViews:[NSArray arrayWithArray:imgs]
                                          anchorPoint:CGPointMake(self.frame.size.width - 130,
                                                                  self.frame.size.height - 130)];
    self._stack.frame = self.bounds;
    self._stack.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self._stack];
}

@end
