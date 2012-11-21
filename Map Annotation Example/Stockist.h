//
//  Stockist.h
//  Map Annotation Example
//
//  Created by Gilbert Jolly on 12/04/2012.
//  Copyright (c) 2012 We Love Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Stockist : NSObject <MKAnnotation>

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * postcode;

- (CLLocationCoordinate2D)coordinate;

@end
