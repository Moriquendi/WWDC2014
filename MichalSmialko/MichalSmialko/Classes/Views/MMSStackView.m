//
//  MMSStackView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/7/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

//
// Thanks Rob for 'dragging' code.
// Slightly modified by myself.
// http://stackoverflow.com/questions/21325057/implement-uikitdynamics-for-dragging-view-off-screen/21346822#21346822
//

#import "MMSStackView.h"
#import "NSArray+Utils.h"

@interface MMSStackView ()
@property (nonatomic, strong) UIPanGestureRecognizer *_pan;
@property (nonatomic, strong) UIDynamicAnimator *_animator;
@property (nonatomic, strong) UIAttachmentBehavior *_attachment;
@property (nonatomic, strong) NSArray *_stackViews;
@property (nonatomic) CGPoint _anchorPoint;
@end

@implementation MMSStackView


#pragma mark - UIView

- (instancetype)initWithViews:(NSArray *)stackViews anchorPoint:(CGPoint)anchor
{
    if (self = [self initWithFrame:CGRectZero]) {
        self._anchorPoint = anchor;
        self._stackViews = stackViews;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self._animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self._stackViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectMake(0, 0, obj.frame.size.width, obj.frame.size.height);
        obj.center = self._anchorPoint;
        obj.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4 / 3 * idx);
        [self addSubview:obj];
    }];
    
    self._pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pan:)];
    [[self._stackViews lastObject] addGestureRecognizer:self._pan];
}

#pragma mark - MMStackView ()

- (void)_reload
{
    // Make sure last object is above all and first object is behind all
    if (self.superview) {
        [self._stackViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
        [self._stackViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            [self addSubview:obj];
        }];
    }
    
    self._pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pan:)];
    [[self._stackViews lastObject] addGestureRecognizer:self._pan];
}

- (void)handle_pan:(UIPanGestureRecognizer *)gesture
{
    static CGPoint               startCenter;
    
    // variables for calculating angular velocity
    static CFAbsoluteTime        lastTime;
    static CGFloat               lastAngle;
    static CGFloat               angularVelocity;
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [self._animator removeAllBehaviors];
        
        startCenter = gesture.view.center;
        
        // calculate the center offset and anchor point
        CGPoint pointWithinAnimatedView = [gesture locationInView:gesture.view];
        
        UIOffset offset = UIOffsetMake(pointWithinAnimatedView.x - gesture.view.bounds.size.width / 2.0,
                                       pointWithinAnimatedView.y - gesture.view.bounds.size.height / 2.0);
        
        CGPoint anchor = [gesture locationInView:gesture.view.superview];
        
        // create attachment behavior
        self._attachment = [[UIAttachmentBehavior alloc] initWithItem:gesture.view
                                                     offsetFromCenter:offset
                                                     attachedToAnchor:anchor];
        
        // code to calculate angular velocity (seems curious that I have to calculate this myself, but I can if I have to)
        lastTime = CFAbsoluteTimeGetCurrent();
        lastAngle = [self _angleOfView:gesture.view];
        
        self._attachment.action = ^{
            CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
            CGFloat angle = [self _angleOfView:gesture.view];
            if (time > lastTime) {
                angularVelocity = (angle - lastAngle) / (time - lastTime);
                lastTime = time;
                lastAngle = angle;
            }
        };
        
        // add attachment behavior
        
        [self._animator addBehavior:self._attachment];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        // as user makes gesture, update attachment behavior's anchor point, achieving drag 'n' rotate
        CGPoint anchor = [gesture locationInView:gesture.view.superview];
        self._attachment.anchorPoint = anchor;
        
        CGPoint translation = [gesture translationInView:gesture.view.superview];
        CGFloat distance = sqrt(translation.x * translation.x + translation.y * translation.y);
        
        // Large
        CGFloat scale = 1.f + distance / 2000;
        [self._stackViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            if (idx != [self._stackViews count] - 1) {
                CGFloat rotationAngle = atan2(obj.transform.b, obj.transform.a);
                obj.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
                obj.transform = CGAffineTransformRotate(obj.transform, rotationAngle);
            }
        }];
        
        
#warning Optimize with CORE ANIMATION
        UIView *bottomView = [self._stackViews firstObject];
        bottomView.layer.shadowColor = [[UIColor blackColor] CGColor];
        bottomView.layer.shadowOpacity = 0.8;
        bottomView.layer.shadowRadius = distance / 5.f;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        // Scaling naim
        [self._stackViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:0.3 animations:^{
                if (idx != [self._stackViews count] - 1) {
                    CGFloat rotationAngle = atan2(obj.transform.b, obj.transform.a);
                    obj.transform = CGAffineTransformRotate(CGAffineTransformIdentity, rotationAngle);
                }
            }];
        }];
        // Shadow
        UIView *bottomView = [self._stackViews firstObject];
        bottomView.layer.shadowOpacity = 0;
        
        //
        [self._animator removeAllBehaviors];
        
        // if we aren't dragging it down, just snap it back and quit
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:gesture.view
                                                        snapToPoint:startCenter];
        snap.damping = 3.f;
        UIDynamicItemBehavior * dynamicItem = [[UIDynamicItemBehavior alloc] initWithItems:@[gesture.view]];
        dynamicItem.allowsRotation = NO;
        
        [self._animator addBehavior:dynamicItem];
        [self._animator addBehavior:snap];
        
        // Remove _pan gesture from old view
        [gesture.view removeGestureRecognizer:gesture];
        
        // Swap views
        self._stackViews = [self._stackViews arrayByMovingObjectsForward];
        [self _reload];

        return;
    }
}

- (CGFloat)_angleOfView:(UIView *)view
{
    return atan2(view.transform.b, view.transform.a);
}

@end
