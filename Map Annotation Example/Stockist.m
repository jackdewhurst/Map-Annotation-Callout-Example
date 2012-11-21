//
//  Stockist.m
//  Singha
//
//  Created by Gilbert Jolly on 12/04/2012.
//  Copyright (c) 2012 We Love Mobile. All rights reserved.
//

#import "Stockist.h"

@implementation Stockist

@synthesize latitude;
@synthesize longitude;
@synthesize name;
@synthesize postcode;


- (Stockist*)init
{
    if (self == [super init])
    {
        
    }
    return self;
}


- (CLLocationCoordinate2D)coordinate
{
	return CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
}



@end
