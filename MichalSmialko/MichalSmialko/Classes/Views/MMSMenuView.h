//
//  MMSMenuView.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSCubeButton.h"

@interface MMSMenuView : UIView

/**
 MMSCubeButtons
 */
@property (nonatomic, strong) NSArray *buttons;

- (void)animateButtonSelection:(UIButton *)button complection:(void (^)(void))complection;
- (void)animateButtonAppearanceComplection:(void (^)(void))complection;

@end
