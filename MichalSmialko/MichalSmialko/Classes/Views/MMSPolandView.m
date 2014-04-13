//
//  MMSPolandView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/13/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSPolandView.h"
#import "MMSStyleSheet.h"

@interface MMSPolandView ()
@property (nonatomic, strong, readwrite) MKMapView *mapView;
@property (nonatomic, strong) UIView *_contentView;
@property (nonatomic, strong) UILabel *_titleLabel;
@property (nonatomic, strong) UILabel *_detailsLabel;
@end

@implementation MMSPolandView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[MMSStyleSheet sharedInstance] redColor];
    
        // Map view
        self.mapView = [[MKMapView alloc] init];
        self.mapView.userInteractionEnabled = NO;
        self.mapView.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.mapView.layer.borderWidth = 14;
        self.mapView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4/2.f);
        [self addSubview:self.mapView];

        // Add 'Cracow' pin
        MKPointAnnotation *annotatino = [[MKPointAnnotation alloc] init];
        annotatino.coordinate = CLLocationCoordinate2DMake(50.061755, 19.937496);
        annotatino.title = @"Krakow";
        [self.mapView addAnnotation:annotatino];
        
        // Content
        self._contentView = [[UIView alloc] init];
        self._contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self._contentView];
        
        //
        self._titleLabel = [[UILabel alloc] init];
        self._titleLabel.text = @"About me...";
        self._titleLabel.font = [UIFont systemFontOfSize:56.];
        [self._titleLabel sizeToFit];
        self._titleLabel.textColor = [UIColor colorWithWhite:230./255. alpha:1.];
        [self._contentView addSubview:self._titleLabel];
        
        self._detailsLabel = [[UILabel alloc] init];
        self._detailsLabel.text = @"So I am Michal Smialko and I live in Krakow. Blah blah. I've started programming in secondary school and bla bla";
        self._detailsLabel.font = [UIFont systemFontOfSize:20.];
        self._detailsLabel.textColor = self._titleLabel.textColor;
        self._detailsLabel.numberOfLines = 0;
        [self._contentView addSubview:self._detailsLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mapView.frame = CGRectMake(self.frame.size.width/2.f,
                                    self.frame.size.height/2.f - 250,
                                    310,
                                    460);
    
    self._contentView.frame = CGRectMake(0,
                                         0,
                                         self.frame.size.width/2.f,
                                         self.frame.size.height);
    
    self._titleLabel.frame = CGRectMake(70,
                                        100,
                                        self._titleLabel.frame.size.width,
                                        self._titleLabel.frame.size.height);
    self._detailsLabel.frame = CGRectMake(70,
                                          self._titleLabel.frame.origin.y +
                                          self._titleLabel.frame.size.height + 20,
                                          self._titleLabel.frame.size.width,
                                          300);
}

@end
