//
//  GasStop.h
//  SaveTrack
//
//  Created by Jose Miranda on 8/27/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Car;

@interface GasStop : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * gallons;
@property (nonatomic, retain) NSNumber * miles;
@property (nonatomic, retain) NSNumber * pricepergallon;
@property (nonatomic, retain) Car *car;

@end
