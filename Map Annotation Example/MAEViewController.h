//
//  SIMapViewController.h
//  Map Annotation Example
//
//  Created by Jack Dewhurst on 11/04/2012.
//  Copyright (c) 2012 We Love Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MAEViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (void)directionsPressed:(id)stockist;

@end
