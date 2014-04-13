//
//  MMSCubesMenu.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSCubesMenu.h"
#import "MMSCubeView.h"
#import "MMSStyleSheet.h"

@interface MMSCubesMenu ()
@property (nonatomic) BOOL _animating;
@property (nonatomic, strong, readwrite) NSArray *buttons;
@end

@implementation MMSCubesMenu

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self._animating) {
        return;
    }
    
    CGPoint startPoint = CGPointMake(160, 110);
    CGFloat radius = [[self.buttons firstObject] frame].size.width/2.f;
    radius += 1;
    
    [self.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.center = CGPointMake(startPoint.x + radius * (idx % 2),
                                 startPoint.y + (radius + radius/2.f) * idx);
    }];
}

#pragma mark - MMSCubesMenu

- (instancetype)initWithFrame:(CGRect)frame buttonsCount:(NSInteger)count
{
    if (self = [self initWithFrame:frame]) {
        self._animating = NO;
        
        MMSStyleSheet *styles = [MMSStyleSheet sharedInstance];
        NSArray *colors = @[[styles darkRedColor],
                            [styles tealColor],
                            [styles yellowColor],
                            [styles lightBlueColor]];
        
        NSMutableArray *allButtons = [NSMutableArray array];
        for (NSInteger i=0; i<count; i++) {
            MMSCubeView *cubeView = [[MMSCubeView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
            cubeView.fillColor = colors[i % [colors count]];
            cubeView.userInteractionEnabled = NO;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = cubeView.frame;
            [btn addSubview:cubeView];
            [allButtons addObject:btn];
            
            [self addSubview:btn];
        }
        
        self.buttons = [NSArray arrayWithArray:allButtons];
    }
    return self;
}

- (void)animateButtonsAppearance
{
    self._animating = YES;
    [self.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000.0;
        CGPoint anchor;
        if (idx % 2 == 0) {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI_2, 1.0f, -0.5f, 0.0f);
            anchor = CGPointMake(0.1, 0.1);
        }
        else {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI_2, 1.0f, 0.5f, 0.0f);
            anchor = CGPointMake(0.9, 0.1);
        }

        obj.layer.transform = rotationAndPerspectiveTransform;
        [self _setAnchorPoint:anchor forView:obj];
        obj.alpha = 0.4f;
    }];

    [self.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:0.35 delay:0.2 * idx options:0 animations:^{
            obj.alpha = 1.f;
            obj.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished){
            [self _setAnchorPoint:CGPointMake(0.5, 0.5) forView:obj];
        }];
    }];

}

#pragma mark - MMSCubesMenu ()

/**
 Thanks! http://stackoverflow.com/questions/9645723/how-to-rotate-an-layer-at-a-specific-anchor-point-without-a-skip
 */
-(void)_setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

@end
