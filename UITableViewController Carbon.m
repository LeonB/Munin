//
//  UITableViewController Carbon.m
//  Munin
//
//  Created by Leon Bogaert on 14-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "UITableViewController Carbon.h"

@implementation UITableViewController (Carbon)

- (void)viewDidLoad {
	[super viewDidLoad];
	
	//background image aanpassen
	UIImage *backgroundImage = [UIImage imageNamed:@"carbon1.png"];
	UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
	self.tableView.backgroundView = backgroundView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString *sectionTitle = nil;
	if ([self respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
		 sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
	}
	
//	NSLog(@"tableView: %@", tableView);
//	NSLog(@"section: %i", section);
	
	CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, height)];
	//tableView.sectionHeaderHeight = headerView.frame.size.height;
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 380 - 20, 22)];
	label.text = sectionTitle;
	label.font = [UIFont boldSystemFontOfSize:16.0];
	//label.font = [UIFont systemFontOfSize:16.0];
	label.shadowOffset = CGSizeMake(0, 1);
	label.shadowColor = [UIColor grayColor];
	label.backgroundColor = [UIColor clearColor];
	
	label.textColor = [UIColor whiteColor];

	[headerView addSubview:label];
	[label release];
	return [headerView autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	NSString *sectionTitle = nil; //very important!
	if ([self respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
		sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
	}
	
    if (sectionTitle == nil || [sectionTitle isEqualToString:@""]) {
		return 8;
    }

	return 40;
}

@end