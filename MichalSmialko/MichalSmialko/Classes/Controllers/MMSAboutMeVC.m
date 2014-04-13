//
//  MMSAboutMeVC.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/12/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSAboutMeVC.h"
#import "MMSAboutMeView.h"

@interface MMSAboutMeVC ()
@property (nonatomic, strong) MMSAboutMeView *_aboutView;
@end

@implementation MMSAboutMeVC

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // About me
    self._aboutView = [[MMSAboutMeView alloc] initWithFrame:self.view.bounds];
    self._aboutView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self._aboutView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self performSelector:@selector(_zoomMapToCracow) withObject:nil afterDelay:1.0];
}

#pragma mark - MMSAboutMeVC

- (void)_zoomMapToCracow
{
    MKMapView *mapView = self._aboutView.polandView.mapView;
    CLLocationCoordinate2D cords = CLLocationCoordinate2DMake(50.069755, 19.937496);
    MKMapCamera *cam = [MKMapCamera cameraLookingAtCenterCoordinate:cords
                                                  fromEyeCoordinate:cords
                                                        eyeAltitude:9500];
    [mapView setCamera:cam animated:YES];
}

@end
