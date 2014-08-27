//
//  STViewHistoryTableViewController.m
//  SaveTrack
//
//  Created by Jose Miranda on 8/20/14.
//  Copyright (c) 2014 Jose Miranda. All rights reserved.
//

#import "STViewHistoryTableViewController.h"
#import "STViewInformationTableViewCell.h"
#import <CoreData/CoreData.h>
#import "Car.h"
#import "GasStop.h"
@interface STViewHistoryTableViewController ()
{
    Car *privateCar;
    NSArray *currentGasStop;
}
@end

@implementation STViewHistoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"STViewInformationTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GasStopViewCell"];
    
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
    privateCar = [fetchResults objectAtIndex:0];
    //grabbing the unsorted array from the NSSet
    NSArray *unsortedArray = [privateCar.gasstops allObjects];
    
    
    //this will sort the array by date
    currentGasStop = [unsortedArray sortedArrayUsingComparator:^NSComparisonResult(GasStop *a, GasStop *b){
        return [b.date compare:a.date];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [currentGasStop count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STViewInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GasStopViewCell" forIndexPath:indexPath];
    
    
    
        //NSEntityDescription *entityDescrition = [NSEntityDescription entityForName:@"GasStop" inManagedObjectContext:context];

    GasStop *stop = [currentGasStop objectAtIndex:indexPath.row];
    
    
    cell.milesDrivenLabel.text = [NSString stringWithFormat:@"%@", stop.miles];
    cell.pricePerGallonLabel.text = [NSString stringWithFormat:@"%@", stop.pricepergallon];
    cell.totalGallonsLabel.text = [NSString stringWithFormat:@"%@", stop.gallons];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    cell.dateLabel.text = [dateFormatter stringFromDate:stop.date];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma - Back Navigation

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
