//
//  MMSStackView.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/7/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMSStackView : UIView

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

- (instancetype)initWithViews:(NSArray *)stackViews frame:(CGRect)frame;

@end
