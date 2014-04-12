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
    
    CGPoint center = CGPointMake(self.frame.size.width/2.f,
                                 self.frame.size.height/2.f);
    
    // Top
    [path moveToPoint:CGPointMake(center.x, 0)];
    
    // Right top
    [path addLineToPoint:CGPointMake(center.x + radius * threeSqt / 2., radius/2.f)];
    
    // Right bottom
    [path addLineToPoint:CGPointMake(center.x + radius * threeSqt / 2., radius + radius/2.f)];
    
    // Bottom
    [path addLineToPoint:CGPointMake(center.x , radius*2)];
    
    // Left bottom
    [path addLineToPoint:CGPointMake(center.x - radius * threeSqt / 2.f, radius + radius/2.f)];
    
    // Left top
    [path addLineToPoint:CGPointMake(center.x - radius * threeSqt / 2.f, radius/2.f)];
    
    // Close
    [path closePath];
    
    // Fill with color
    CGContextSetFillColorWithColor(context, [self.fillColor CGColor]);
    [path fill];
    
    CGContextRestoreGState(context);
}

@end
