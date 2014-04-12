//
//  MMSCubesMenu.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMSCubesMenu : UIView

@property (nonatomic, strong, readonly) NSArray *buttons;

- (instancetype)initWithFrame:(CGRect)frame buttonsCount:(NSInteger)count;

@end
