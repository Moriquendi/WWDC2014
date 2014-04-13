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
@property (weak, nonatomic, readwrite) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *_detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *_aghLabel;
@property (weak, nonatomic) IBOutlet UILabel *_travelLabel;
@property (weak, nonatomic) IBOutlet UILabel *_baseLabel;
@property (weak, nonatomic) IBOutlet UILabel *_coffeeLabel;
@end

@implementation MMSPolandView

#pragma mark - UIView

- (void)awakeFromNib
{
    self.backgroundColor = [[MMSStyleSheet sharedInstance] lightBlueColor];

    // Map view
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
    
    //
    self._titleLabel.text = @"About me...";
    self._titleLabel.font = [UIFont systemFontOfSize:56.];
    [self._titleLabel sizeToFit];
    self._titleLabel.textColor = [UIColor colorWithWhite:230./255. alpha:1.];
    [self addSubview:self._titleLabel];
    
    self._detailsLabel.text = @"So I am Michal Smialko and I live in Krakow. Blah blah. I've started programming in secondary school and bla bla";
    self._detailsLabel.font = [UIFont systemFontOfSize:20.];
    self._detailsLabel.textColor = self._titleLabel.textColor;
    self._detailsLabel.numberOfLines = 0;
    [self addSubview:self._detailsLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mapView.frame = CGRectMake(self.frame.size.width/2.f,
                                    100,
                                    310,
                                    460);
    
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

- (void)sizeToFit
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            1720);
}

@end
