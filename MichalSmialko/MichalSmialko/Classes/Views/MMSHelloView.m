//
//  MMSHelloView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSHelloView.h"
#import "MMSStyleSheet.h"

@interface MMSHelloView ()
@property (nonatomic, strong) UILabel *_helloLabel;
@property (nonatomic, strong) UILabel *_nameLabel;
@property (nonatomic, strong) UILabel *_myStoryLabel;
@end

@implementation MMSHelloView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Self
        self.backgroundColor = [[MMSStyleSheet sharedInstance] lightBackgroundColor];
        
        // Hello label
        self._helloLabel = [[UILabel alloc] init];
        self._helloLabel.text = @"Hello...";
        self._helloLabel.font = [[MMSStyleSheet sharedInstance] headerFont];
        [self._helloLabel sizeToFit];
        [self addSubview:self._helloLabel];
        
        // Name label
        self._nameLabel = [[UILabel alloc] init];
        self._nameLabel.text = @"I'm Michal";
        self._nameLabel.font = [[MMSStyleSheet sharedInstance] headerFont];
        [self._nameLabel sizeToFit];
        self._nameLabel.alpha = 0.f;
        [self addSubview:self._nameLabel];
        
        // Here's my story label
        self._myStoryLabel = [[UILabel alloc] init];
        self._myStoryLabel.text = @"Here's my story";
        self._myStoryLabel.font = [[MMSStyleSheet sharedInstance] subHeaderFont];
        [self._myStoryLabel sizeToFit];
        self._myStoryLabel.alpha = 0.f;
        [self addSubview:self._myStoryLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    const CGFloat HORIZONTAL_MARGIN = 20;
    
    /// Hello label
    self._helloLabel.frame = CGRectMake(HORIZONTAL_MARGIN,
                                       self.frame.size.height/2.f - self._helloLabel.frame.size.height/2.f,
                                       self._helloLabel.frame.size.width,
                                       self._helloLabel.frame.size.height);
    self._helloLabel.frame = CGRectApplyAffineTransform(self._helloLabel.frame, self._helloLabel.transform);
    
    // Name label
    self._nameLabel.center = CGPointMake(self.frame.size.width/2.f,
                                        self.frame.size.height/2.f);
    
    /// Story label
    self._myStoryLabel.center = CGPointMake(self._nameLabel.center.x,
                                            self._nameLabel.center.y +
                                            self._nameLabel.frame.size.height +
                                            self._myStoryLabel.frame.size.height/2.f + 20);
}

#pragma mark - MMSHelloView

- (void)startAnimation
{
    [UIView animateWithDuration:2.0 animations:^{
        // Move hello label
        self._helloLabel.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,
                                                               self.frame.size.width,
                                                               0);
        self._helloLabel.alpha = 0.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            // Fade in name label
            self._nameLabel.alpha = 1.f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5
                                  delay:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 // Fade in my story label after delay
                                 self._myStoryLabel.alpha = 1.f;
            }
                             completion:nil];
        }];
    }];
}

@end
