//
//  MMSAGHacksDetailsView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/9/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSAGHacksDetailsView.h"

@interface MMSAGHacksDetailsView ()
@property (nonatomic, strong, readwrite) UILabel *detailsLabel;
@end

@implementation MMSAGHacksDetailsView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.detailsLabel = [[UILabel alloc] init];
        self.detailsLabel.text = @"I'm the main organizer of AGHacks - first students hackathon in Kraków. We plan to gather hundreds of students from all around the country so they can learn, teach, make friends and experiment with new technology.";
        self.detailsLabel.textColor = [UIColor whiteColor];
        self.detailsLabel.numberOfLines = 0;
        self.detailsLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:30.0];
        self.detailsLabel.shadowOffset = CGSizeMake(1, 1);
        self.detailsLabel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:self.detailsLabel];
        self.detailsLabel.textAlignment = NSTextAlignmentJustified;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailsLabel.frame = CGRectMake(0,
                                         0,
                                         self.frame.size.width * 0.6,
                                         self.frame.size.height * 0.9);
    self.detailsLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                           CGRectGetMidY(self.bounds));
}

@end
