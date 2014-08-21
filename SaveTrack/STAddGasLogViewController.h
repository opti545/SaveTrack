//
//  STAddGasLogViewController.h
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STAddGasLogViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *milesDrivenTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalGallonsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pricePerGallonTextField;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
