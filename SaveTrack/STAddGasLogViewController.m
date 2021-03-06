//
//  STAddGasLogViewController.m
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import "STAddGasLogViewController.h"
#import "Car.h"
#import "GasStop.h"

#import <CoreData/CoreData.h>
@interface STAddGasLogViewController ()

@end

@implementation STAddGasLogViewController

-(NSMutableArray *)gasHistory{
    if (!_gasHistory)_gasHistory = [[NSMutableArray alloc]init];
    return _gasHistory;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)isValidData{
    
    
    if ([self.milesDrivenTextField.text isEqualToString:@""]){
        return NO;
    }
    if ([self.totalGallonsTextField.text isEqualToString:@""]) {
        return NO;
    }
    if ([self.pricePerGallonTextField.text isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}
- (IBAction)save:(id)sender {
    
    if(![self isValidData]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Check your Data!" message:@"It appears that you left something that we didn't like, please fix and retry" delegate:self cancelButtonTitle:nil otherButtonTitles: @"OK",nil];
        [alertView show];
        return;
    }
    //Fetch Request to get Car everytime the view appears
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Car"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"model" ascending:YES]];
    
    id delegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSError* error = nil;
    
    NSArray *fetchResults = [context executeFetchRequest:request error:&error];
    if ([fetchResults count] == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    //Create an Car object to get the first Car Only
    Car * currentCar = [fetchResults objectAtIndex:0];
    NSEntityDescription *entityDescrition = [NSEntityDescription entityForName:@"GasStop" inManagedObjectContext:context];
    
    GasStop *currentGasStop = [[GasStop alloc]initWithEntity:entityDescrition insertIntoManagedObjectContext:context];
    currentGasStop.car = currentCar;
    [currentGasStop setDate:[NSDate date]];
    currentGasStop.gallons = [NSNumber numberWithFloat:[self.totalGallonsTextField.text floatValue]];
    currentGasStop.pricepergallon = [NSNumber numberWithFloat:[self.pricePerGallonTextField.text floatValue]];
    currentGasStop.miles = [NSNumber numberWithInteger:[self.milesDrivenTextField.text integerValue]];
    [currentCar addGasstopsObject:currentGasStop];
    
    NSError *errors = nil;
    if (![context save:&errors]) {
        NSLog(@"Something occurred while saving a gas Stop");
    }
    NSLog(@"Gas Stop Saved to Car %@", currentCar.model);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
