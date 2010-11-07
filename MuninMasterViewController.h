//
//  MuninMasterViewController.h
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MuninMaster.h"
#import "HostTableViewCell.h"
#import "UITableViewControllerWithRefresh.h"
#import "HostViewController.h"

@interface MuninMasterViewController : UITableViewControllerWithRefresh {
	MuninMaster *muninMaster;
	NSArray *hosts;
	HostViewController *hostViewController;
}

@property (nonatomic, retain) MuninMaster *muninMaster;
@property (nonatomic, retain) NSArray *hosts;
@property (nonatomic, retain) HostViewController *hostViewController;

- (void)sortHosts;
- (void)configureCell:(HostTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath inBackground:(Boolean)background;
- (void)didSelectHostCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)loadHostView:(Host *)host;

@end
