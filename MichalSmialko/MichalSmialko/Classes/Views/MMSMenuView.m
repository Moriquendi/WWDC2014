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

@interface MMSMenuView ()
@property (nonatomic) BOOL animating;
@property (nonatomic, strong) UIDynamicAnimator *_animator;
@end

@implementation MMSMenuView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.animating = NO;
        self._animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.backgroundColor = [[MMSStyleSheet sharedInstance] lightBackgroundColor];
        
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:4];
        for (NSInteger i=0; i<4; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 200, 200);
            [self addSubview:btn];
            
            [buttons addObject:btn];
        }

        [buttons[0] setBackgroundColor:[[MMSStyleSheet sharedInstance] lightBlueColor]];
        [buttons[1] setBackgroundColor:[[MMSStyleSheet sharedInstance] redColor]];
        [buttons[2] setBackgroundColor:[[MMSStyleSheet sharedInstance] tealColor]];
        [buttons[3] setBackgroundColor:[[MMSStyleSheet sharedInstance] yellowColor]];
        
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
        CGFloat x = (self.frame.size.width - 80) / [self.buttons count];
        obj.center = CGPointMake(130 + x * idx,
                                 CGRectGetMidY(self.bounds));
        
        CGFloat cornerRadius = obj.frame.size.width/2.f;
        obj.layer.cornerRadius = cornerRadius;
    }];
}

#pragma mark - MMSMenuView

- (void)animateButtonSelection:(UIButton *)button complection:(void (^)(void))complection
{
    self.animating = YES;

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
        [self.buttons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
            for (NSInteger i=0; i<25; i++) {
                // Create new bullet
                UIView *bullet = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                bullet.backgroundColor = obj.backgroundColor;
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
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 block:^{
            [self._animator removeBehavior:snap];
            [UIView animateWithDuration:0.5 animations:^{
                button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 8, 8);
            } completion:^(BOOL finished) {
                if (complection) {
                    complection();
                }
            }];
        } repeats:NO];
        
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

@end
