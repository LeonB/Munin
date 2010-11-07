//
//  MuninMastersViewController.m
//  Munin
//
//  Created by Leon Bogaert on 31-10-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "MuninMastersViewController.h"
#import "MuninMasterTableViewCell.h"
#import "MuninMaster.h"

@implementation MuninMastersViewController
@synthesize fetchedResultsController, managedObjectContext, muninMasterViewController;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    [addButtonItem release];
	
	self.title = @"Dashboard!";
	
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	NSInteger count = [[fetchedResultsController sections] count];
	NSLog(@"fetchedResultsController: %@", fetchedResultsController);
	NSLog(@"Count: %i", count);
	return count+1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch (section) {
		case 1:
			return @"Munin Masters";
			break;
	}
	
	return @"";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSInteger numberOfRows = 0;
	
	switch (section) {
		case 2:
			
			if ([[fetchedResultsController sections] count] > 0) {
				id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
				numberOfRows = [sectionInfo numberOfObjects];
			}
			
			return numberOfRows;
			break;

		default:
			return 1;
			break;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"indexPath.section: %i", indexPath.section);
	
	if (indexPath.section == 1) {
		// Dequeue or if necessary create a RecipeTableViewCell, then set its recipe to the recipe for the current row.
		static NSString *MuninMasterCellIdentifier = @"MuninMasterCellIdentifier";
		
		MuninMasterTableViewCell *muninMasterCell = (MuninMasterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MuninMasterCellIdentifier];
		if (muninMasterCell == nil) {
			muninMasterCell = [[[MuninMasterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MuninMasterCellIdentifier] autorelease];
		}
		
		[self configureCell:muninMasterCell atIndexPath:indexPath];
		
		return muninMasterCell;
	}
	
	//Anders een gewone cel!
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)configureCell:(MuninMasterTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
	
	NSIndexPath *newIndexpath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
	MuninMaster *muninMaster = (MuninMaster *)[fetchedResultsController objectAtIndexPath:newIndexpath];
    cell.muninMaster = muninMaster;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section) {
		case 1:
			return YES;
			break;
	}
	return NO;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"commitEditingStyle editingStyle: %@", editingStyle);
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Navigation logic may go here. Create and push another view controller.
//	/*
//	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//	 [self.navigationController pushViewController:detailViewController animated:YES];
//	 [detailViewController release];
//	 */
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath inBackground:(Boolean)background {
	switch (indexPath.section) {
		case 1:
			[self didSelectMuninMasterCellAtIndexPath:indexPath];
			break;
	}
}
			 
 - (void)didSelectMuninMasterCellAtIndexPath:(NSIndexPath *)indexPath {
	 NSIndexPath *newIndexpath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
	 MuninMaster *muninMaster = (MuninMaster *)[fetchedResultsController objectAtIndexPath:newIndexpath];
	 [self loadMuninMasterView:muninMaster];
 }

- (void)loadMuninMasterView:(MuninMaster *)muninMaster {
	NSLog(@"loadMuninMasterView");
	
	MuninMasterViewController *controller;
	//if (![controller.muninMaster.name isEqual:muninMaster.name]) { // =! Kan! Want autoId is een integer....
		controller = [[MuninMasterViewController alloc] initWithNibName:@"MuninMasterViewController" bundle:nil];
		
		controller.muninMaster = muninMaster;
		
		self.muninMasterViewController = controller;
		[controller release];
	//}
	
	[self.navigationController pushViewControllerOnMainThread:self.muninMasterViewController animated:YES];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
	NSLog(@"fetchedResultsController called");
	
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"MuninMaster" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
		
		//NSLog(@"Entity: %@", entity);
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return fetchedResultsController;
}

#pragma mark -
#pragma mark NSFetchedResultsController methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath {
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"controllerDidChangeContent: %@", controller);
	if ([self.muninMasterViewController respondsToSelector:@selector(controllerDidChangeContent:)]) {
		[self.muninMasterViewController controllerDidChangeContent:controller];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

