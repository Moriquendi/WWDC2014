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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGPoint startPoint = CGPointMake(130, 150);
    [self.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.center = CGPointMake(startPoint.x, startPoint.y + 180*idx);
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
            [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
            [allButtons addObject:btn];
            
            [self addSubview:btn];
        }
        
        self.buttons = [NSArray arrayWithArray:allButtons];
    }
    return self;
}

- (void)test:(id)sender
{
    NSLog(@"asdasda");
}

@end
