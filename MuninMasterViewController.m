//
//  MuninMasterViewController.m
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "MuninMasterViewController.h"
#import "HostTableViewCell.h"
#import "HostViewController.h"

@implementation MuninMasterViewController
@synthesize muninMaster, hosts, hostViewController;

#pragma mark -
#pragma mark View lifecycle

//- (void)setMuninMaster:(MuninMaster *)newMuninMaster {
//	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//	
//	newMuninMaster.hosts = [NSSet setWithArray:[[newMuninMaster.hosts allObjects] sortedArrayUsingDescriptors:sortDescriptors]];
//	muninMaster = newMuninMaster;
//	
//	[sortDescriptor release];
//	[sortDescriptors release];
//}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = [NSString stringWithFormat:@"%@", self.muninMaster.name];
	
	if (!self.muninMaster.lastSynced) {
		NSLog(@"muninMaster is nog niet gesynced!");
		[self.muninMaster sync];
		//[self.tableView reloadData];
	}
	[self sortHosts];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)sortHosts {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSArray *sortedHosts = [[muninMaster.hosts allObjects] sortedArrayUsingDescriptors:sortDescriptors];
	self.hosts = sortedHosts;
	
	[sortDescriptor release];
	[sortDescriptors release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//	NSLog(@"Geladen!");
//}

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
	//return self.muninMaster.hosts;
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	NSLog(@"[self.muninMaster.hosts count]: %i", [self.muninMaster.hosts count]);
	return [self.muninMaster.hosts count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *HostCellIdentifier = @"HostCellIdentifier";
	
	HostTableViewCell *hostTableViewCell = (HostTableViewCell *)[tableView dequeueReusableCellWithIdentifier:HostCellIdentifier];
	if (hostTableViewCell == nil) {
		hostTableViewCell = [[[HostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HostCellIdentifier] autorelease];
	}
	
	[self configureCell:hostTableViewCell atIndexPath:indexPath];
	
	return hostTableViewCell;
}

- (void)configureCell:(HostTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
	Host *host = [self.hosts objectAtIndex:indexPath.row];
    cell.host = host;
}

- (void)reloadTableViewDataSource {
	[super reloadTableViewDataSource];
	self.muninMaster.url = @"http://monitor.tim-online.nl";
	[self.muninMaster performSelectorInBackground:@selector(sync) withObject:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath inBackground:(Boolean)background {
	[self didSelectHostCellAtIndexPath:indexPath];
}

- (void)didSelectHostCellAtIndexPath:(NSIndexPath *)indexPath {
	Host *host = [self.hosts objectAtIndex:indexPath.row];
	[self loadHostView:host];
}

- (void)loadHostView:(Host *)host {
	NSLog(@"loadHostView");
	
	HostViewController *controller = self.hostViewController;
	if (![controller.host.name isEqual:host.name]) { // =! Kan! Want autoId is een integer....
		controller = [[HostViewController alloc] initWithNibName:@"HostViewController" bundle:nil];
		
		controller.host = host;
		
		self.hostViewController = controller;
		[controller release];
	}
	
	[self.navigationController pushViewControllerOnMainThread:self.hostViewController animated:YES];
}


#pragma mark -
#pragma mark NSFetchedResultsController methods

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self sortHosts];
	[self.tableView reloadData];
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
	[muninMaster release];
    [super dealloc];
}


@end

