//
//  STViewController.m
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import "STViewController.h"
#import "STAddCarViewController.h"
#import "Car.h"
#import "GasStop.h"
#import <CoreData/CoreData.h>

@interface STViewController () <UIAlertViewDelegate>
{
    enum{
        ALERTVIEW_ADD_CAR,
    };
    Car* privateCar;
    NSArray *currentGasStop;
}

@end

@implementation STViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![self carIsPresent]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No Cars Found!" message:@"It seems that you are new to SaveTrack, Please Add a Car" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Add a Car", nil];
        [alertView show];
        
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //Fetch Request to get Car everytime the view appears
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Car"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"model" ascending:YES]];
    
    id delegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSError* error = nil;
    
    NSArray *fetchResults = [context executeFetchRequest:request error:&error];
    if ([fetchResults count] == EMPTY_ARRAY) {
        return;
    }
    //Create an Car object to get the first Car Only
    Car * car = [fetchResults objectAtIndex:0];
    NSString *carInfo = [NSString stringWithFormat:@"%@ %@ %@", [car.year stringValue],car.make, car.model];
    
    self.carName.text = carInfo;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Fetch Request to get Car everytime the view appears
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Car"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"model" ascending:YES]];
    
    id delegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSError* error = nil;
    
    NSArray *fetchResults = [context executeFetchRequest:request error:&error];
    if ([fetchResults count] == 0) {
        return;
    }
    //Create an Car object to get the first Car Only
    privateCar = [fetchResults objectAtIndex:0];
    //grabbing the unsorted array from the NSSet
    NSArray *unsortedArray = [privateCar.gasstops allObjects];
    
    if ([unsortedArray count] == 0) {
        return;
    }
    
    //this will sort the array by date
    currentGasStop = [unsortedArray sortedArrayUsingComparator:^NSComparisonResult(GasStop *a, GasStop *b){
        return [b.date compare:a.date];
    }];
    //Get the first one or most recent from the sorted array
    GasStop *lastStop = [currentGasStop objectAtIndex:0];

    NSNumber *mpg = [NSNumber numberWithFloat:[lastStop.miles intValue]/[lastStop.gallons floatValue]];
    self.mpgSinceLastRecordLabel.text = [NSString stringWithFormat:@"%.2f", [mpg floatValue]];
    NSString *carInfo = [NSString stringWithFormat:@"%@ %@ %@", [privateCar.year stringValue],privateCar.make, privateCar.model];
    
    self.carName.text = carInfo;

    

}
-(BOOL) carIsPresent{
    //Fetch Request to get Car everytime the view appears
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Car"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"model" ascending:YES]];
    id delegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSError* error = nil;
    
    NSArray *fetchResults = [context executeFetchRequest:request error:&error];
    if ([fetchResults count] == EMPTY_ARRAY) {
        return NO;
    }
    return YES;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    STAddCarViewController *addCarViewController;
    //If Button was pressed For Adding
    switch (buttonIndex) {
        case ALERTVIEW_ADD_CAR:
            addCarViewController = [[STAddCarViewController alloc]init];
            [self presentViewController:addCarViewController animated:YES completion:nil];
            break;
        default:
            break;
    }
}

@end
