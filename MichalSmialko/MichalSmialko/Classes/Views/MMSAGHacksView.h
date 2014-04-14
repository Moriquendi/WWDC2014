//
//  MMSAGHacksView.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MMSAGHacksView : UIView

@property (nonatomic, strong, readonly) UIScrollView *contentView;
@property (nonatomic, strong, readonly) MPMoviePlayerController *moviePlayerController;

@end
