//
//  MMSLearnTeachView.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/11/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSCocoaHeadsView.h"
#import "MMSEventsView.h"

@interface MMSLearnTeachView : UIView

@property (nonatomic, strong, readonly) MMSCocoaHeadsView *cocoaHeadsView;
@property (nonatomic, strong, readonly) MMSEventsView *eventsView;
@property (nonatomic, strong, readonly) UIButton *nextButton;

@end
