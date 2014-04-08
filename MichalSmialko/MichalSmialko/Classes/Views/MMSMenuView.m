//
//  MMSMenuView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSMenuView.h"
#import "MMSStyleSheet.h"

@implementation MMSMenuView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[MMSStyleSheet sharedInstance] darkBlueColor];
        
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
    [super layoutSubviews];

    [self.buttons enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds),
                                     CGRectGetMidY(self.bounds));
        CGFloat radius = 200;
        
        CGFloat angle = (360 / [self.buttons count]) * idx;
        angle = M_PI * angle / 180; // To radians
        obj.center = CGPointMake(center.x + radius * cos(angle),
                                 center.y + radius * sin(angle));
        
        
        CGFloat cornerRadius = obj.frame.size.width/2.f;
        obj.layer.cornerRadius = cornerRadius;
    }];
}

@end
