//
//  MMSCubeButton.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/13/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSCubeButton.h"

@interface MMSCubeButton ()
@property (nonatomic, strong, readwrite) MMSCubeView *bgView;
@property (nonatomic, strong, readwrite) UILabel *largeTitleLabel;
@end

@implementation MMSCubeButton

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Cube
        MMSCubeView *cube = [[MMSCubeView alloc] initWithFrame:self.bounds];
        cube.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cube.userInteractionEnabled = NO;
        self.bgView = cube;
        [self addSubview:cube];
        
        // Title
        self.largeTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.largeTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.largeTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.largeTitleLabel.font = [UIFont systemFontOfSize:90.];
        self.largeTitleLabel.textColor = [UIColor whiteColor];
        self.largeTitleLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1./3, 1./3);
        [self addSubview:self.largeTitleLabel];
    }
    return self;
}

@end
