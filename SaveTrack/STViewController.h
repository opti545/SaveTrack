//
//  STViewController.h
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define EMPTY_ARRAY 0
@interface STViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *carName;


@property (strong, nonatomic) IBOutlet UILabel *mpgSinceLastRecordLabel;

-(BOOL) carIsPresent;

@end
