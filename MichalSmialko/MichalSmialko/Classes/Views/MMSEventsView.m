//
//  MMSCocoaCampView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/11/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSEventsView.h"
#import "MDScratchImageView.h"
#import "MMSStackView.h"
#import "UIImage+Utils.h"
#import "MMSStyleSheet.h"

@interface MMSEventsView () <MDScratchImageViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *campTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *campDetailsLabel;
@end

@implementation MMSEventsView

#pragma mark - UIView

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundColor = [UIColor colorWithWhite:210./255. alpha:1.];
    
    // Cocoa camp
    NSMutableArray *photos = [NSMutableArray array];
    for (NSInteger i=0; i<3; i++) {
        NSString *imageName = [@"cc" stringByAppendingString:[NSString stringWithFormat:@"%li.jpg", i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(0, 0, 250, 250);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [photos addObject:imageView];
    }
    MMSStackView *cocoaCampStack = [[MMSStackView alloc] initWithViews:photos
                                                           anchorPoint:CGPointMake(250, 490)];
    cocoaCampStack.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    cocoaCampStack.frame = self.bounds;
    [self addSubview:cocoaCampStack];
    
    // WWDC
    NSMutableArray *wwdcPhotos = [NSMutableArray array];
    for (NSInteger i=0; i<2; i++) {
        NSString *imageName = [@"wwdc" stringByAppendingString:[NSString stringWithFormat:@"%li.jpg", i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(0, 0, 250, 250);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [wwdcPhotos addObject:imageView];
    }
    MMSStackView *WWDCStack = [[MMSStackView alloc] initWithViews:wwdcPhotos
                                                      anchorPoint:CGPointMake(750, 490)];
    WWDCStack.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    WWDCStack.frame = self.bounds;
    [self addSubview:WWDCStack];
    
    // Scratch overlay
    MDScratchImageView *scratchView = [[MDScratchImageView alloc] initWithFrame:self.bounds];
    scratchView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scratchView.delegate = self;
    UIImage *img = [UIImage imageWithColor:[[MMSStyleSheet sharedInstance] yellowColor]];
    [scratchView setImage:img radius:35];
    scratchView.frame = self.bounds;
    [self addSubview:scratchView];
    
    UIImageView *mask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask"]];
    scratchView.layer.mask = mask.layer;
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
//                self.blurredBgView.alpha = 0.f;
//
//                [self.labels enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
//                    obj.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
//                    obj.alpha = 0.f;
//                }];
            } completion:^(BOOL finished) {
                [scratchImageView removeFromSuperview];
//
//                [self _showDetails];
            }];
        }
    }
    else {
//        self.blurredBgView.alpha = MIN(1 - maskingProgress + 0.4, 1.);
    }
}

@end
