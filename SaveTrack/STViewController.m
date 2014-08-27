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

@interface STViewController () <UIAlertViewDelegate>

enum{
    ALERTVIEW_ADD_CAR,
};
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
