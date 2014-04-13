//
//  MMSStyleSheet.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMSStyleSheet : NSObject

+ (instancetype)sharedInstance;

// Colors
- (UIColor *)lightBackgroundColor;

- (UIColor *)darkBlueColor;
- (UIColor *)lightBlueColor;
- (UIColor *)redColor;
- (UIColor *)darkRedColor;
- (UIColor *)tealColor;
- (UIColor *)yellowColor;


// Fonts
- (UIFont *)headerFont;
- (UIFont *)subHeaderFont;

@end
