//
//  WhereamIViewController.m
//  WhereamI
//
//  Created by Ryan Blunden on 1/14/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import "WhereamIViewController.h"
#import "BNRMapPoint.h"

@interface WhereamIViewController ()

@end

@implementation WhereamIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    locationManager = [[CLLocationManager alloc] init];

    [locationManager setDelegate:self];

    // As accurate as possible
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
  }

  return self;
}

- (void)viewDidLoad {
  [worldView setShowsUserLocation:YES];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

  // How many seconds ago was this new location created?
  NSTimeInterval  t = [[newLocation timestamp] timeIntervalSinceNow];

  // CLLocationManager will return the last found location of the
  // device first, you don't want that data in this case.
  // If this location was made more than 3 minutes ago, ignore it.
  if (t < -180) {
    // This is cached data, you don't want it, keep looking
    return;
  }

  [self foundLocation:newLocation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  CLLocationCoordinate2D loc = [userLocation coordinate];
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
  [worldView setRegion:region animated:YES];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  NSLog(@"Could not find location: %@", error);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self findLocation];

  [textField resignFirstResponder];

  return YES;
}

- (void)findLocation {
  [locationManager startUpdatingLocation];
  [activityInidcator startAnimating];
  [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc {
  CLLocationCoordinate2D coord = [loc coordinate];

  // Create an instance of BNRMapPoint with the curent data
  BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];

  // Add it to the map view
  [worldView addAnnotation:mp];

  // Zoom the region to this location
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
  [worldView setRegion:region animated:YES];

  // Reset the UI
  [locationTitleField setText:@""];
  [activityInidcator stopAnimating];
  [locationTitleField setHidden:NO];
  [locationManager stopUpdatingLocation];
}

- (void)dealloc {
  // Tell the location manager to stop sending us messages
  [locationManager setDelegate:nil];
}

@end
