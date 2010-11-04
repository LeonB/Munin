//
//  MuninMastersViewController.h
//  Munin
//
//  Created by Leon Bogaert on 31-10-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleTableViewControllerActions.h"
#import "MuninMasterViewController.h"
#import "MuninMasterTableViewCell.h"

@interface MuninMastersViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
@private
	NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
	MuninMasterViewController *muninMasterViewController;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) MuninMasterViewController *muninMasterViewController;

- (void)configureCell:(MuninMasterTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectMuninMasterCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)loadMuninMasterView:(MuninMaster *)muninMaster;

@end
