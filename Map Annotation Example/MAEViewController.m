//
//  SIMapViewController.m
//  Map Annotation Example
//
//  Created by Jack Dewhurst on 11/04/2012.
//  Copyright (c) 2012 We Love Mobile. All rights reserved.
//

#import "MAEViewController.h"
#import "StockistAnnotationView.h"
#import "Stockist.h"

@interface MAEViewController ()
{
    
}
@end

@implementation MAEViewController
@synthesize mapView = _mapView;



#pragma mark - UIViewController Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create an annotation to show on our map, My custom MKAnnotation class is called "Stockist".
    Stockist *stockist = [[Stockist alloc] init];
        
    [stockist setLatitude:[NSNumber numberWithFloat:51.525834]];
    [stockist setLongitude:[NSNumber numberWithFloat:-0.101624]];
    [stockist setName:@"Test Stockist"];
    [stockist setPostcode:@"TN22 3HR"];
        
    [self.mapView addAnnotation:stockist];
    
    
    // Set the mapView to center on our annotation.
    [self.mapView setRegion:MKCoordinateRegionMake(stockist.coordinate, MKCoordinateSpanMake(0.01, 0.01))];

    [self.mapView setShowsUserLocation:YES];
}


- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Annotation Callback Methods

// This method gets called when the directions button is tapped on any annotation in our mapview.
// For this example I'm just showing a UIAlertView with the annotation name.

- (void)directionsPressed:(Stockist*)stockist
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Directions" message:[NSString stringWithFormat:@"Directions button pressed for \"%@\"", stockist.name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}



#pragma mark - MKMapViewDelegate Methods

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated {    
}



- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(Stockist*)annotation
{
	if (![annotation isMemberOfClass:[MKUserLocation class]]) {
        StockistAnnotationView *annotationView = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:@"stockist"];
        if (!annotationView) {
            annotationView = [[StockistAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"stockist"];
        }

        [annotationView setupWithStockist:annotation];
        
        // Important - give the MKAnnotationView a rererence to our current UIViewController so we can call a method in this class later on.
        [annotationView setParent:self];
        
		return annotationView;
	}
	
	return nil;
}



// This method just animates in the annotations from above the mapView.. much like google maps used to do with the 'drop pin' animation in their app.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    double delay = 0.0;
    for (StockistAnnotationView *view in views) {
        CGRect endFrame = view.frame;
        CGRect startFrame = endFrame;
        startFrame.origin.y = [mapView annotationVisibleRect].origin.y - startFrame.size.height;
        view.frame = startFrame;
        [UIView beginAnimations:@"drop" context:NULL];
        [UIView setAnimationDuration:0.6f];
        [UIView setAnimationDelay:delay];
        view.frame = endFrame;
        [UIView commitAnimations];
        delay += 0.1;
    }
}



@end
