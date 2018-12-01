//
//  ViewController.h
//  Zadanie9
//
//  Created by Ewelina on 22/11/17.
//  Copyright © 2017 Ewelina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>



@property(weak, nonatomic) IBOutlet UILabel *latitudeLabel;

@property(weak, nonatomic) IBOutlet UILabel *longtitudeLabel;

@property(weak, nonatomic) IBOutlet UILabel *addressLabel;

@property(weak, nonatomic) IBOutlet UILabel *gestureLabel;

-(IBAction)tapGesture:(UITapGestureRecognizer *)sender;

-(IBAction)pinchGesture:(UITapGestureRecognizer *)sender;

-(IBAction)swipeGesture:(UITapGestureRecognizer *)sender;

-(IBAction)longPressGesture:(UITapGestureRecognizer *)sender;

- (IBAction)getCurrentLocation:(id)sender;

@end

