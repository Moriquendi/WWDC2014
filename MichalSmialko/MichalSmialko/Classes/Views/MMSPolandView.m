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
@property (weak, nonatomic) IBOutlet UIImageView *_aghImageView;
@property (weak, nonatomic) IBOutlet UIImageView *_travelImageView;
@property (weak, nonatomic) IBOutlet UIImageView *_baseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *_coffeeImageView;
@end

@implementation MMSPolandView

#pragma mark - UIView

- (void)awakeFromNib
{
    self.backgroundColor = [[MMSStyleSheet sharedInstance] lightBlueColor];

    // Map view
    self.mapView.userInteractionEnabled = NO;
    [self _restyleView:self.mapView];
    self.mapView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4/2.f);
    [self addSubview:self.mapView];
    
    [self _restyleView:self._aghImageView];
    self._aghImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4/5.f);
    
    [self _restyleView:self._travelImageView];
    self._travelImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4/5.f);
    
    [self _restyleView:self._coffeeImageView];
    self._coffeeImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4/5.f);

    // Add 'Cracow' pin
    MKPointAnnotation *annotatino = [[MKPointAnnotation alloc] init];
    annotatino.coordinate = CLLocationCoordinate2DMake(50.061755, 19.937496);
    annotatino.title = @"Krakow";
    [self.mapView addAnnotation:annotatino];
    
    //
    self._titleLabel.font = [UIFont systemFontOfSize:56.];
    self._titleLabel.textColor = [UIColor colorWithWhite:230./255. alpha:1.];
    [self._titleLabel sizeToFit];
    [self addSubview:self._titleLabel];

    [self _restyleLabel:self._detailsLabel];
    self._detailsLabel.numberOfLines = 0;
    [self addSubview:self._detailsLabel];
    
    // Restyle labels
    [self _restyleLabel:self._aghLabel];
    [self _restyleLabel:self._travelLabel];
    [self _restyleLabel:self._baseLabel];
    [self _restyleLabel:self._coffeeLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
        
    self.mapView.frame = CGRectMake(self.frame.size.width/2.f,
                                    100,
                                    310,
                                    460);
}

- (void)sizeToFit
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            1020);
}

#pragma mark - MMSPolandView ()

- (void)_restyleView:(UIView *)view
{
    view.layer.borderColor = [[UIColor whiteColor] CGColor];
    view.layer.borderWidth = 14;
}

- (void)_restyleLabel:(UILabel *)label
{
    label.font = [UIFont systemFontOfSize:20.];
    label.textColor = self._titleLabel.textColor;
}

@end
