//
//  UIImage+Utils.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/13/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

#pragma mark + UIImage (Utils)

/**
 Thanks Matt!
 http://stackoverflow.com/questions/6496441/creating-a-uiimage-from-a-uicolor-to-use-as-a-background-image-for-uibutton
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
