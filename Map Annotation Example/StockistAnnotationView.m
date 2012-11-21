//
//  StockistAnnotationView.m
//  Singha
//
//  Created by Jack Dewhurst on 30/04/2012.
//  Copyright (c) 2012 We Love Mobile. All rights reserved.
//

#import "StockistAnnotationView.h"
#import <QuartzCore/QuartzCore.h>

@implementation StockistAnnotationView

@synthesize calloutView;
@synthesize nameLbl;
@synthesize addressLbl;
@synthesize directionsButton;
@synthesize imgView;
@synthesize originalFrame;
@synthesize stockist = _stockist;
@synthesize parent;

- (id)initWithAnnotation:(Stockist*)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	
	if (self) {		
		self.frame = CGRectMake(-26, -105, 52, 70);
		
		self.imgView= [[UIImageView alloc] initWithFrame:CGRectMake(11, 6, 35, 35)];
		[self addSubview:imgView];
		self.centerOffset = CGPointMake(0, -35);
		self.canShowCallout = FALSE;
		self.originalFrame = self.frame;
		self.backgroundColor = [UIColor clearColor];
		self.image = [UIImage imageNamed:@"pin_closed.png"];
		self.clipsToBounds = FALSE;
        calloutVisible = NO;
        hitTestBuffer = NO;
	}
	
	return self;
}


- (void)setupWithStockist:(Stockist*)stockist
{
    self.stockist = stockist;
    [nameLbl setText:stockist.name];
    [addressLbl setText:stockist.postcode];
}


// This method basically animates in the calloutView nib file once the MKAnnotationView is selected.
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	if (selected) {
        calloutVisible = YES;
        hitTestBuffer = NO;
        self.calloutView = [[[NSBundle mainBundle] loadNibNamed:@"CalloutView" owner:self options:nil] objectAtIndex:0];  
        [calloutView setFrame:CGRectMake(0, 0, 0, calloutView.frame.size.height)];		
        [calloutView setAlpha:0.0f];    
        [self addSubview:calloutView];
        [self sendSubviewToBack:calloutView];
        
                
        [UIView animateWithDuration:0.3f delay:0.0f options:0 animations:^{
            [calloutView setFrame:CGRectMake(calloutView.frame.origin.x, calloutView.frame.origin.y, 280, calloutView.frame.size.height)];		
            [calloutView setAlpha:1.0f];
        } completion:^(BOOL finished) {
        }];

        [nameLbl setText:self.stockist.name];
        [addressLbl setText:self.stockist.postcode];    

        
        [super setSelected:selected animated:animated];

    } else {
        calloutVisible = NO;
        CGRect newFrame = self.frame;
        newFrame.size.width = 52;
        self.frame = newFrame;
        
        [UIView animateWithDuration:0.3f delay:0.0f options:0 animations:^{
            [calloutView setFrame:CGRectMake(calloutView.frame.origin.x, calloutView.frame.origin.y, 0, calloutView.frame.size.height)];		
            [calloutView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [calloutView removeFromSuperview];
            calloutView = nil;
        }];
	}
}


// This method is called from our hittest method below once a touch is detected on "directionsButton".
- (void)directionsPressed:(id)sender
{
    // Calls our parent (MAEViewController) to show an alertView.
    if ([parent respondsToSelector:@selector(directionsPressed:)])
        [parent performSelector:@selector(directionsPressed:) withObject:self.stockist];
}


// Called whenever the MKAnnotationView is touched.
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (calloutVisible) {
        
        //Get the touch point relevant to "directionsButton".
        CGPoint hitPoint = [calloutView convertPoint:point toView:directionsButton];
        
        //If Touch is detected inside "directionsButton" then call our directionsPressed method. Set buffers to prevent multiple taps in quick succession.
        if ([calloutView pointInside:hitPoint withEvent:event]) {
            if (!hitTestBuffer) {
                [self directionsPressed:nil];
                hitTestBuffer = YES;
            }
            return [directionsButton hitTest:point withEvent:event];
        } else {
            hitTestBuffer = NO;
        }
    }
	return [super hitTest:point withEvent:event];
}


@end
