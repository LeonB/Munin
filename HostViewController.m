//
//  HostViewController.m
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "HostViewController.h"
#import "HostData.h"
#import "Service.h"
#import "Plugin.h"
#import "PluginTableViewCell.h"

@implementation HostViewController
@synthesize host, plugins;

- (NSFetchedResultsController *)plugins {
	if (plugins == NULL) {
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"Plugin" inManagedObjectContext:self.host.managedObjectContext];
		
        NSSortDescriptor *sortDescriptorSection = [[NSSortDescriptor alloc] initWithKey:@"service.name" ascending:YES]; //nodig anders geeft 'ie een "has an out of order section name" melding
        NSSortDescriptor *sortDescriptorName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptorSection, sortDescriptorName, nil];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY hostDatas.host == %@", self.host];
		
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		[fetchRequest setEntity:entity];
		[fetchRequest setPredicate:predicate];
        [fetchRequest setSortDescriptors:sortDescriptors];
		
		NSError *error;
		plugins = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.host.managedObjectContext sectionNameKeyPath:@"service.name" cacheName:@"Plugins"];
		plugins.delegate = self;
		
		NSLog(@"Going to perform fetch");
		[plugins performFetch:&error];
		
		NSLog(@"[fetchRequest release]");
		[fetchRequest release];
	}
	return plugins;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = self.host.name;
	
	//NSFetchedPropertyDescription *propDesc = [[self.host.entity propertiesByName] objectForKey:@"services"];
	
	//NSError *error;
	//NSFetchRequest *request = [propDesc fetchRequest];
	//NSArray *array = [[self.host managedObjectContext] executeFetchRequest:request error:&error];
	//NSLog(@"array: %@", array);
	
	if (!self.host.lastSynced) {
		NSLog(@"host is nog niet gesynced!");
		[self.host sync];
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
    NSInteger count = [[self.plugins sections] count];

	if (count == 0) {
		count = 1;
	}
	
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
	
    // Return a title or nil as appropriate for the section.	
    if ([[self.plugins sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.plugins sections] objectAtIndex:section];
		title = [sectionInfo name];
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numberOfRows = 0;
	
    if ([[self.plugins sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.plugins sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *PluginCellIdentifier = @"PluginCellIdentifier";
	
	PluginTableViewCell *pluginTableViewCell = (PluginTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PluginCellIdentifier];
	if (pluginTableViewCell == nil) {
		pluginTableViewCell = [[[PluginTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PluginCellIdentifier] autorelease];
	}
	
	[self configureCell:pluginTableViewCell atIndexPath:indexPath];
	
	return pluginTableViewCell;
}

- (void)configureCell:(PluginTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
	Plugin *plugin = [self.plugins objectAtIndexPath:indexPath];
    cell.plugin = plugin;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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

