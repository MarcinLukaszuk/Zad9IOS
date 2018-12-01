//
//  ViewController.m
//  Zadanie9
//
//  Created by Ewelina on 22/11/17.
//  Copyright © 2017 Ewelina. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc]init];
    geocoder = [[CLGeocoder alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)canBecomeFirstResponder
{
    return YES; }
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event
{
    if(motion ==UIEventSubtypeMotionShake)
    {
        UIAlertController *alertDialog= [UIAlertController alertControllerWithTitle:@"Uwaga" message:@"Telefon został potrząśnięty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction= [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [alertDialog addAction:defaultAction];
        [self presentViewController:alertDialog animated:YES completion:nil];
    }
}

-(IBAction)tapGesture:(UITapGestureRecognizer *)sender{
    _gestureLabel.text = @"Wykonano gest dotknięcia";
}

-(IBAction)pinchGesture:(UITapGestureRecognizer *)sender{
    _gestureLabel.text = @"Wykonano gest uszczypnięcia";
}

-(IBAction)swipeGesture:(UITapGestureRecognizer *)sender{
    _gestureLabel.text = @"Wykonano gest machnięcia w prawo";
}

-(IBAction)longPressGesture:(UITapGestureRecognizer *)sender{
    _gestureLabel.text = @"Wykonano gest dłuższego dotknięcia";
}

- (IBAction)getCurrentLocation:(id)sender{
    locationManager.delegate = self;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation); CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        _longtitudeLabel.text = [NSString stringWithFormat:@"%.8f",
                                 currentLocation.coordinate.longitude];
        _latitudeLabel.text = [NSString stringWithFormat:@"%.8f",
                               currentLocation.coordinate.latitude]; }
    // geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error); if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            _addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                  placemark.thoroughfare,
                                  placemark.subThoroughfare,
                                  placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

@end
