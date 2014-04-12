//
//  MMSCubesMenu.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSCubesMenu.h"
#import "MMSCubeView.h"

@interface MMSCubesMenu ()
@property (nonatomic, strong, readwrite) NSArray *buttons;
@end

@implementation MMSCubesMenu

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSArray *colors = @[];
    
    CGPoint startPoint = CGPointMake(110, 110);
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
        NSMutableArray *allButtons = [NSMutableArray array];
        for (NSInteger i=0; i<count; i++) {
            MMSCubeView *cubeView = [[MMSCubeView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
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

@end
