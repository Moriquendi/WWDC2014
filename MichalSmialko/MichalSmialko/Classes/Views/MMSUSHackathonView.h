//
//  MMSUSHackathons.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/10/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMSUSHackathonView : UIView

@property (nonatomic, strong, readonly) UIScrollView *contentView;
@property (nonatomic, strong, readonly) UIImageView *logoView;
@property (nonatomic, strong, readonly) UILabel *detailsLabel;

@property (nonatomic, strong) NSArray *stackViews;

@end
