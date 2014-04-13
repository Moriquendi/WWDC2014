//
//  MMSCocoaHeadsView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/10/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSCocoaHeadsView.h"
#import "MDScratchImageView.h"
#import "UIView+Effects.h"
#import "UIImage+ImageEffects.h"
#import "MMSStackView.h"
#import "UIImage+Utils.h"
#import "MMSStyleSheet.h"

@interface MMSCocoaHeadsView () <MDScratchImageViewDelegate>
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) UIImageView *blurredBgView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *_titleLabel;
@end

@implementation MMSCocoaHeadsView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Background Image
        self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chBg.jpeg"]];
        self.bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.bgView.frame = self.bounds;
        [self addSubview:self.bgView];
        
        UIImage *blurredBgImage = [self.bgView.image applyLightEffect];
        self.blurredBgView = [[UIImageView alloc] initWithImage:blurredBgImage];
        self.blurredBgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.blurredBgView.frame = self.bounds;
        [self addSubview:self.blurredBgView];
        
        // Logo
        self.logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chLogo"]];
        self.logoView.alpha = 0.f;
        [self addSubview:self.logoView];
        
        // Labels
        NSMutableArray *labels = [[NSMutableArray alloc] init];
        NSArray *texts = @[@"Curiosity",
                           @"Learn",
                           @"Teach",
                           @"Friends",
                           @"Passion"];
        for (NSInteger i=0; i<5; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:@"Helvetica" size:60.];
            label.textColor = [UIColor colorWithWhite:235./255. alpha:1.];
            label.text = texts[i];
            label.backgroundColor = [UIColor clearColor];
            [label sizeToFit];
            [labels addObject:label];
            [self addSubview:label];
        }
        [labels[0] setCenter:CGPointMake(200, 250)];
        [labels[1] setCenter:CGPointMake(350, 450)];
        [labels[2] setCenter:CGPointMake(540, 310)];
        [labels[3] setCenter:CGPointMake(550, 550)];
        [labels[4] setCenter:CGPointMake(780, 320)];
        
        self.labels = [NSArray arrayWithArray:labels];
        
        //
        self._titleLabel = [[UILabel alloc] init];
        self._titleLabel.text = @"Cocoa Heads";
        self._titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:75.];
        self._titleLabel.textColor = [UIColor whiteColor];
        self._titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                        CGRectGetMidY(self.bounds));
        self._titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        [self._titleLabel sizeToFit];
        self._titleLabel.alpha = 0.f;
        [self addSubview:self._titleLabel];
        
        MDScratchImageView *scratchView = [[MDScratchImageView alloc] initWithFrame:self.bounds];
        scratchView.delegate = self;
        UIImage *img = [UIImage imageWithColor:[[MMSStyleSheet sharedInstance] yellowColor]];
        scratchView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scratchView.frame = self.bounds;
        [scratchView setImage:img radius:35];
        [self addSubview:scratchView];
        
        UIImageView *mask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask"]];
        scratchView.layer.mask = mask.layer;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.logoView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                       CGRectGetMidY(self.bounds) - 150);
    self._titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                       CGRectGetMidY(self.bounds));
}

#pragma mark - MMSCocoaHeadsView ()

- (void)_showDetails
{
    // Footer
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              self.frame.size.height - 210,
                                                              self.frame.size.width,
                                                              210)];
    footer.backgroundColor = [UIColor clearColor];
    [self addSubview:footer];
    
    // Blur
    [self.blurredBgView removeFromSuperview];
    [footer addSubview:self.blurredBgView];
    self.blurredBgView.frame = [self convertRect:self.blurredBgView.frame toView:footer];
    self.blurredBgView.alpha = 1.f;
    footer.clipsToBounds = YES;

    // Details label
    UILabel *detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,
                                                                      0,
                                                                      footer.frame.size.width/3.,
                                                                      footer.frame.size.height)];
    detailsLabel.text = @"I'm the co-organizer of Cocoa Heads meetups in Kraków for almost two years. Each month, dozens of iOS and OS X developers gather together to learn and share their knowledge with others.";
    detailsLabel.font = [UIFont systemFontOfSize:18.];
    detailsLabel.textColor = [UIColor colorWithWhite:235.f/255. alpha:1.];
    detailsLabel.numberOfLines = 0;
    [footer addSubview:detailsLabel];
    
    // Stack view
    NSMutableArray *photos = [NSMutableArray array];
    for (NSInteger i=0; i<4; i++) {
        NSString *imageName = [@"ch" stringByAppendingString:[NSString stringWithFormat:@"%li.jpeg", i+1]];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.frame = CGRectMake(0, 0, 250, 250);
        imgView.userInteractionEnabled = YES;
        [photos addObject:imgView];
    }
    
    NSArray *stackViews = photos;
    MMSStackView *stack = [[MMSStackView alloc] initWithViews:stackViews
                                                  anchorPoint:CGPointMake(self.frame.size.width - 250,
                                                                          self.frame.size.height - 170)];
    stack.frame = self.bounds;
    [self addSubview:stack];

    // Anim
    self.logoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1./100, 1./100.);
    self._titleLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1./100, 1./100.);
    footer.alpha = 0.f;
    
    [UIView animateWithDuration:0.4 animations:^{
        footer.alpha = 1.f;
        
        self.logoView.alpha = 1.f;
        self.logoView.transform = CGAffineTransformIdentity;
        
        self._titleLabel.alpha = 1.f;
        self._titleLabel.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - <MDScratchImageViewDelegate>

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress
{
    if (maskingProgress > 0.45) {
        if (scratchImageView.userInteractionEnabled) {
            scratchImageView.userInteractionEnabled = NO;
            
            [UIView animateWithDuration:1.0 animations:^{
                scratchImageView.alpha = 0.f;
                scratchImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
                self.blurredBgView.alpha = 0.f;
                
                [self.labels enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                    obj.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
                    obj.alpha = 0.f;
                }];
            } completion:^(BOOL finished) {
                [scratchImageView removeFromSuperview];
                
                [self _showDetails];
            }];
        }
    }
    else {
        self.blurredBgView.alpha = MIN(1 - maskingProgress + 0.4, 1.);
    }
}

@end
