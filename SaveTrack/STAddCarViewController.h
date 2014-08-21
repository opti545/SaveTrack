//
//  STAddCarViewController.h
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STAddCarViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *makeTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
