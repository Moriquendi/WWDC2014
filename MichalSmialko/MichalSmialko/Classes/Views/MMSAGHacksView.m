
//  MMSAGHacksView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSAGHacksView.h"
#import "MMSAGHacksDetailsView.h"
#import "MMSStyleSheet.h"

@interface MMSAGHacksView ()
@property (nonatomic, strong, readwrite) MPMoviePlayerController *moviePlayerController;

@property (nonatomic, strong, readwrite) UIScrollView *contentView;
@property (nonatomic, strong) UIImageView *_logoView;
@property (nonatomic, strong) UILabel *_titleLabel;
@property (nonatomic, strong) MMSAGHacksDetailsView *_detailsView;
@end

@implementation MMSAGHacksView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AGHacksPromo" ofType:@"mov"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
        [self.moviePlayerController prepareToPlay];
        self.moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
        self.moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
        self.moviePlayerController.view.frame = self.bounds;
        self.moviePlayerController.view.userInteractionEnabled = NO;
        self.moviePlayerController.repeatMode = MPMovieRepeatModeOne;
        [self addSubview:self.moviePlayerController.view];
        

        //
        self.contentView = [[UIScrollView alloc] init];
        self.contentView.scrollEnabled = NO;
        self.contentView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
        [self addSubview:self.contentView];
        
        self._logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AGHacksLogo"]];
        [self._logoView sizeToFit];
        self._logoView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self._logoView];
        
        self._titleLabel = [[UILabel alloc] init];
        self._titleLabel.text = @"AGHacks";
        self._titleLabel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self._titleLabel.shadowOffset = CGSizeMake(1, 1);
        self._titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:140];
        [self._titleLabel sizeToFit];
        self._titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self._titleLabel];
        
        self._detailsView = [[MMSAGHacksDetailsView alloc] init];
        [self.contentView addSubview:self._detailsView];
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.moviePlayerController performSelector:@selector(play) withObject:nil afterDelay:0.2];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.moviePlayerController.view.frame = self.bounds;
    
    CGFloat height = 500;
    self.contentView.frame = CGRectMake(0,
                                        self.frame.size.height/2.f - height/2.f,
                                        self.frame.size.width,
                                        height);
    self.contentView.contentSize = CGSizeMake(self._detailsView.frame.size.width * 3,
                                               height);
    
    self._logoView.center = CGPointMake(self.contentView.frame.size.width/2.f,
                                        CGRectGetMidY(self.contentView.bounds));
    
    self._titleLabel.center = CGPointMake(self.contentView.frame.size.width + self.contentView.frame.size.width/2.f,
                                          CGRectGetMidY(self.contentView.bounds));
    
    self._detailsView.frame = CGRectMake(self.contentView.frame.size.width * 2,
                                         0,
                                         self.contentView.frame.size.width,
                                         self.contentView.frame.size.height);
}

@end
