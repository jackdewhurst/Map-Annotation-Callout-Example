//
//  StockistAnnotationView.m
//  Map Annotation Example
//
//  Created by Jack Dewhurst on 30/04/2012.
//  Copyright (c) 2012 We Love Mobile. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Stockist.h"

@interface StockistAnnotationView : MKAnnotationView
{
    BOOL calloutVisible;
    BOOL hitTestBuffer;
}

@property (nonatomic, retain) UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIView *calloutView;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *addressLbl;
@property (strong, nonatomic) IBOutlet UILabel *directionsButton;
@property (nonatomic) CGRect originalFrame;
@property (nonatomic, retain) Stockist *stockist;
@property (nonatomic, retain) id parent;

- (void)directionsPressed:(id)sender;

- (void)setupWithStockist:(Stockist*)stockist;
- (id)initWithAnnotation:(Stockist*)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
