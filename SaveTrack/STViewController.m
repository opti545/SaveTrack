//
//  STViewController.m
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import "STViewController.h"
#import "STAddCarViewController.h"

@interface STViewController ()
enum{
    ALERTVIEW_CANCEL,
    ALERTVIEW_ADD_CAR,
};
@end

@implementation STViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No Cars Found!" message:@"It seems that you are new to SaveTrack, Please Add a Car" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add a Car", nil];
    [alertView show];
    
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
