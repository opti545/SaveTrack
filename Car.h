//
//  Car.h
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GasStop;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * year;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSSet *gasstops;
@end

@interface Car (CoreDataGeneratedAccessors)

- (void)addGasstopsObject:(GasStop *)value;
- (void)removeGasstopsObject:(GasStop *)value;
- (void)addGasstops:(NSSet *)values;
- (void)removeGasstops:(NSSet *)values;

@end
