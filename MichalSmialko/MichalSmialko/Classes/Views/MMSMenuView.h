//
//  MMSMenuView.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMSMenuView : UIView

@property (nonatomic, strong) NSArray *buttons;

- (void)animateButtonSelection:(UIButton *)button complection:(void (^)(void))complection;

@end
