//
//  MMSBurglarsNightView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSBurglarsNightView.h"
#import "MMSStackView.h"
#import "MMSStyleSheet.h"

@interface MMSBurglarsNightView ()
@property (nonatomic, strong) MMSStackView *_stack;
@property (weak, nonatomic) IBOutlet UILabel *_detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *_titleLabel;
@end

@implementation MMSBurglarsNightView

#pragma mark - UIView

- (void)awakeFromNib
{
    //
    self.backgroundColor = [[MMSStyleSheet sharedInstance] darkRedColor];
    
    self._titleLabel.textColor = [UIColor whiteColor];
    self._detailsLabel.textColor = [UIColor whiteColor];
    
    // Stack
    NSMutableArray *views = [NSMutableArray array];
    for (NSInteger i=0; i<2; i++) {
        NSString *imgName = [@"burglars-" stringByAppendingString:[NSString stringWithFormat:@"%li", i+1]];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.userInteractionEnabled = YES;
        [views addObject:imgView];
    }
    
    self._stack = [[MMSStackView alloc] initWithViews:[NSArray arrayWithArray:views] anchorPoint:CGPointMake(300, 550)];
    self._stack.frame = self.bounds;
    [self addSubview:self._stack];
}

@end
