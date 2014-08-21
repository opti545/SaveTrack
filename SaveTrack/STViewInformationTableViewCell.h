//
//  STViewInformationTableViewCell.h
//  SaveTrack
//
//  Created by Jose Miranda on 8/21/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STViewInformationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *milesDrivenLabel;
@property (strong, nonatomic) IBOutlet UILabel *pricePerGallonLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalGallonsLabel;

@end
