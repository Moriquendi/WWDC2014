//
//  MMSStyleSheet.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSStyleSheet.h"

@implementation MMSStyleSheet

#pragma mark + MMStyleSheet

+ (instancetype)sharedInstance
{
    static id sheet;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sheet = [[self alloc] init];
    });
    return sheet;
}

#pragma mark - NSObject

- (instancetype)init
{
    if (self = [super init]) {
        [self _applyAppearanceProxies];
    }
    return self;
}

#pragma mark - MMStyleSheet - Colors

- (UIColor *)lightBackgroundColor
{
    return [UIColor colorWithWhite:229./255. alpha:1.0];
}

- (UIColor *)darkBlueColor
{
    return [UIColor colorWithRed:45./255. green:62./255. blue:82./255. alpha:1.0];
}

- (UIColor *)lightBlueColor
{
    return [UIColor colorWithRed:74./255.
                           green:164./255.
                            blue:216./255. alpha:1.0];
}
- (UIColor *)redColor
{
    return [UIColor colorWithRed:219./255. green:87./255. blue:73./255. alpha:1.0];
}

- (UIColor *)tealColor
{
    return [UIColor colorWithRed:83./255. green:186./255. blue:137./255. alpha:1.0];
}

- (UIColor *)yellowColor
{
    return [UIColor colorWithRed:235./255. green:144./255. blue:29./255. alpha:1.0];
}

#pragma mark - MMStyleSheet - Fonts

- (UIFont *)headerFont
{
    return [UIFont fontWithName:@"Helvetica-Light" size:80.];
}

- (UIFont *)subHeaderFont
{
    return [UIFont fontWithName:@"Helvetica-Light" size:35.];
}

#pragma mark - MMStyleSheet ()

- (void)_applyAppearanceProxies
{
    
}

@end
