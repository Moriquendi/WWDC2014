//
//  MMSCubeView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSCubeView.h"

@implementation MMSCubeView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.fillColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat radius = self.frame.size.width/2.f;
    
    CGFloat threeSqt = sqrtf(3);
    
    // Top
    [path moveToPoint:CGPointMake(threeSqt / 2.f * radius, 0)];
    
    // Right top
    [path addLineToPoint:CGPointMake(threeSqt * radius, radius/2.f)];
    
    // Right bottom
    [path addLineToPoint:CGPointMake(threeSqt * radius, radius + radius/2.f)];
    
    // Bottom
    [path addLineToPoint:CGPointMake(threeSqt / 2.f * radius , radius*2)];
    
    // Left bottom
    [path addLineToPoint:CGPointMake(0, radius + radius/2.f)];
    
    // Left top
    [path addLineToPoint:CGPointMake(0, radius/2.f)];
    
    // Close
    [path closePath];
    
    // Fill with color
    CGContextSetFillColorWithColor(context, [self.fillColor CGColor]);
    [path fill];
    
    CGContextRestoreGState(context);
}

@end
