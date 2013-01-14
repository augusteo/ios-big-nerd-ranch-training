//
//  WhereamIViewController.h
//  WhereamI
//
//  Created by Ryan Blunden on 1/14/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamIViewController : UIViewController
    <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate> {
  CLLocationManager *locationManager;

  IBOutlet MKMapView *worldView;
  IBOutlet UIActivityIndicatorView *activityInidcator;
  IBOutlet UITextField *locationTitleField;
}

- (void)findLocation;
- (void)foundLocation;

@end
