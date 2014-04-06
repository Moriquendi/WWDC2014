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
    return [UIColor colorWithWhite:230./255. alpha:1.0];
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
