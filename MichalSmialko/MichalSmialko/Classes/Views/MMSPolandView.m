//
//  MMSPolandView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/13/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSPolandView.h"

@interface MMSPolandView ()
@property (nonatomic, strong, readwrite) MKMapView *mapView;
@end

@implementation MMSPolandView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mapView = [[MKMapView alloc] init];
        self.mapView.userInteractionEnabled = NO;
        [self addSubview:self.mapView];

        // Add 'Cracow' pin
        MKPointAnnotation *annotatino = [[MKPointAnnotation alloc] init];
        annotatino.coordinate = CLLocationCoordinate2DMake(50.061755, 19.937496);
        annotatino.title = @"Krakow";
        [self.mapView addAnnotation:annotatino];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mapView.frame = CGRectMake(0,
                                     self.frame.size.height - 300,
                                     self.frame.size.width,
                                     300);
}

@end
