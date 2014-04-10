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

@interface MMSCocoaHeadsView () <MDScratchImageViewDelegate>
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) UIImageView *blurredBgView;
@property (nonatomic, strong) UIImageView *bgView;
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
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"Cocoa Heads";
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:70.];
        titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                        CGRectGetMidY(self.bounds));
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        [titleLabel sizeToFit];
        [self addSubview:titleLabel];
        
        MDScratchImageView *scratchView = [[MDScratchImageView alloc] initWithFrame:self.bounds];
        scratchView.delegate = self;
        [scratchView setImage:[UIImage imageNamed:@"hacktechLogo"] radius:25];
        scratchView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scratchView.frame = self.bounds;
        [self addSubview:scratchView];
    }
    return self;
}

#pragma mark - <MDScratchImageViewDelegate>

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress
{
    if (maskingProgress > 0.55) {
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
            }];
        }
    }
    else {
        self.blurredBgView.alpha = MIN(1 - maskingProgress + 0.4, 1.);
    }
}

@end
