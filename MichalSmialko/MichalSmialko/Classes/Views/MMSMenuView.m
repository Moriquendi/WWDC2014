//
//  MMSMenuView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSMenuView.h"
#import "MMSStyleSheet.h"
#import "NSTimer+Blocks.h"
#import <AVFoundation/AVFoundation.h>

@interface MMSMenuView ()
@property (nonatomic) BOOL animating;
@property (nonatomic, strong) UIDynamicAnimator *_animator;
@property (nonatomic, strong) AVAudioPlayer *_audioPlayer;
@end

@implementation MMSMenuView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.animating = NO;
        self._animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.backgroundColor = [[MMSStyleSheet sharedInstance] darkBlueColor];
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgblur.jpg"]];
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        bgView.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        bgView.frame = self.bounds;
        [self addSubview:bgView];
        
        
        // Cubes bg
        UIView *cubesBg = [[UIView alloc] initWithFrame:self.bounds];
        cubesBg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        for (NSInteger i=0; i<20; i++) {
            CGFloat size = 30 + rand() % 80;
            MMSCubeView *view = [[MMSCubeView alloc] initWithFrame:CGRectMake(0, 0,
                                                                              size,
                                                                              size)];
            view.layer.shouldRasterize = YES;
            
            CGFloat randomAlpha = 1. / (rand() % 5 + 5);
            view.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:randomAlpha];
            
            view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            view.center = CGPointMake(rand() % (NSInteger)self.frame.size.width,
                                      rand() % (NSInteger)self.frame.size.height);
            
            [cubesBg addSubview:view];
        }
        UIInterpolatingMotionEffect *effect = [[UIInterpolatingMotionEffect alloc]
                                               initWithKeyPath:@"center.x"
                                               type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        UIInterpolatingMotionEffect *effect2 = [[UIInterpolatingMotionEffect alloc]
                                                initWithKeyPath:@"center.y"
                                                type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        effect.minimumRelativeValue = @(-30.);
        effect.maximumRelativeValue = @(40.);
        effect2.minimumRelativeValue = @(-27);
        effect2.maximumRelativeValue = @(50);
        UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
        group.motionEffects = @[effect2, effect];
        [cubesBg addMotionEffect:group];
        [self addSubview:cubesBg];
        
        //
        MMSStyleSheet *styles = [MMSStyleSheet sharedInstance];
        NSArray *colors = @[[styles lightBlueColor],
                            [styles redColor],
                            [styles tealColor],
                            [styles yellowColor]];
        
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:4];
        for (NSInteger i=0; i<4; i++) {
            MMSCubeButton *btn = [MMSCubeButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 350, 350);
            btn.backgroundColor = [UIColor clearColor];
            [self addSubview:btn];
            btn.bgView.fillColor = colors[i];
            
            [buttons addObject:btn];
            
            
            UIInterpolatingMotionEffect *xEffect = [[UIInterpolatingMotionEffect alloc]
                                                   initWithKeyPath:@"center.x"
                                                   type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
            UIInterpolatingMotionEffect *yEffect = [[UIInterpolatingMotionEffect alloc]
                                                    initWithKeyPath:@"center.y"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            xEffect.minimumRelativeValue = @(-10. - 20*i);
            xEffect.maximumRelativeValue = @(10. + 20*i);
            yEffect.minimumRelativeValue = @(-10 - 20*i);
            yEffect.maximumRelativeValue = @(10 + 20*i);
            
            UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
            group.motionEffects = @[xEffect, yEffect];
            [btn addMotionEffect:group];
        }
        self.buttons = [NSArray arrayWithArray:buttons];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.animating) {
        return;
    }

    [super layoutSubviews];

    [self.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        
        CGFloat radius = obj.frame.size.width/2.f;
        
        obj.center = CGPointMake(radius * (idx + 1) + 70,
                                 CGRectGetMidY(self.bounds) - radius/2.f + radius * 1.5 * (idx % 2) - 40);
    }];
}

#pragma mark - MMSMenuView

- (void)animateButtonSelection:(UIButton *)button complection:(void (^)(void))complection
{
    button.selected = YES;
    self.animating = YES;

    self.userInteractionEnabled = NO;
    
    [self._animator removeAllBehaviors];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.buttons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
            if (obj != button) {
                // Explode
                obj.layer.transform = CATransform3DScale(CATransform3DIdentity, 1./100, 1./100, 1.);
            }
        }];
    } completion:^(BOOL finished) {

        NSMutableArray *bullets = [[NSMutableArray alloc] init];
        [self.buttons enumerateObjectsUsingBlock:^(MMSCubeButton *obj, NSUInteger idx, BOOL *stop) {
            for (NSInteger i=0; i<25; i++) {
                // Create new bullet
                UIView *bullet = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                bullet.backgroundColor = obj.bgView.fillColor;
                bullet.center = obj.center;
                bullet.layer.cornerRadius = bullet.frame.size.width/2.f;
                [self addSubview:bullet];
                
                // Apply random push force to bullets
                UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[bullet]
                                                                        mode:UIPushBehaviorModeInstantaneous];
                NSInteger signX = rand() % 2 == 0 ? 1 : -1;
                NSInteger signY = rand() % 2 == 0 ? 1 : -1;
                CGFloat x = 1. / (rand() % 20 + 1);
                CGFloat y = 1. / (rand() % 20 + 1);
                push.pushDirection = CGVectorMake(signX * x,
                                                  signY * y);
                [self._animator addBehavior:push];
                
                [bullets addObject:bullet];
                
                // Also, fade out bullet
                [UIView animateWithDuration:2.1 animations:^{
                    bullet.alpha = 0.f;
                }];
            }
        }];
        
        // Gravity
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:bullets];
        [self._animator addBehavior:gravity];
        
        //
        [self performSelector:@selector(_removeBullets:) withObject:bullets afterDelay:1.5];
        
        // Zoom
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:button
                                                        snapToPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                                                                CGRectGetMidY(self.bounds))];
        [self._animator addBehavior:snap];
        
        // Play sound
        [self _playSnapSound];
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 block:^{
            [self._animator removeBehavior:snap];
            [UIView animateWithDuration:0.5 animations:^{
                button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 5, 5);
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    ((MMSCubeButton *)button).largeTitleLabel.alpha = 0.f;
                } completion:^(BOOL finished) {
                    [self._animator removeAllBehaviors];
                    
                    self.userInteractionEnabled = YES;
                    
                    if (complection) {
                        complection();
                    }
                }];
            }];
        } repeats:NO];
    }];
}

- (void)animateButtonAppearanceComplection:(void (^)(void))complection
{
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:1.6 animations:^{
        [self.buttons enumerateObjectsUsingBlock:^(MMSCubeButton *obj, NSUInteger idx, BOOL *stop) {
            if (obj.selected) {
                obj.largeTitleLabel.alpha = 1.f;
                obj.alpha = 1.f;
                obj.selected = NO;
            }
        }];
    } completion:^(BOOL finished) {
        self.animating = NO;
        [UIView animateWithDuration:0.6 animations:^{
            [self.buttons enumerateObjectsUsingBlock:^(MMSCubeButton *obj, NSUInteger idx, BOOL *stop) {
                obj.transform = CGAffineTransformIdentity;
            }];
            [self layoutSubviews];
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
            if (complection) {
                complection();
            }
        }];
    }];
}

#pragma mark - MMSMenuView ()

- (void)_removeBullets:(NSMutableArray *)bullets
{
    [self._animator removeAllBehaviors];
    [bullets enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)_playSnapSound
{
    if (!self._audioPlayer) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ping" ofType:@"aifc"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:filePath];
        self._audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                   error:nil];
    }
    
    [self._audioPlayer play];
}

@end
