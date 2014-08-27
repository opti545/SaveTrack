//
//  STAddCarViewController.m
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import "STAddCarViewController.h"
#import "Car.h"

@interface STAddCarViewController ()

@end

@implementation STAddCarViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.yearTextField){
        [self.yearTextField resignFirstResponder];
    }
    if(textField == self.modelTextField){
        [self.modelTextField resignFirstResponder];
    }
    if(textField == self.makeTextField){
        [self.makeTextField resignFirstResponder];
        
    }
    return YES;
    
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)checkValidation{
    if ([self.yearTextField.text isEqualToString:@""]) {
        return NO;
    }
    if ([self.makeTextField.text isEqualToString:@""]) {
        return NO;
    }
    if ([self.modelTextField.text isEqualToString:@""]){
        return NO;
    }
    return YES;
}
- (IBAction)save:(id)sender {
    //check for data Validation
    if (![self checkValidation]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Check your Data!" message:@"It appears that you left something that we didn't like, please fix and retry" delegate:self cancelButtonTitle:nil otherButtonTitles: @"OK",nil];
        [alertView show];
        return;

    }
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    Car * car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:context];
    NSNumber *yearCar = [NSNumber numberWithInteger:[self.yearTextField.text integerValue]];
    car.year = yearCar;
    car.model = self.modelTextField.text;
    car.make = self.makeTextField.text;
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Something occurred when saving your car! %@", error);
    }
    NSLog(@"Car Saved!");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
