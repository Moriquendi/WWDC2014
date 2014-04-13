//
//  MMSCubeButton.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/13/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSCubeView.h"

@interface MMSCubeButton : UIButton

@property (nonatomic, strong, readonly) MMSCubeView *bgView;
@property (nonatomic, strong, readonly) UILabel *largeTitleLabel;

@end
