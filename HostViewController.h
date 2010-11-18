//
//  HostViewController.h
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Host.h"
#import "UITableViewControllerWithRefresh.h"
#import "HostDataViewController.h"
#import "PluginTableViewCell.h"
#import "Plugin.h"

@interface HostViewController : UITableViewControllerWithRefresh <NSFetchedResultsControllerDelegate> {
	Host *host;
	NSFetchedResultsController *hostDatas;
	HostDataViewController *hostDataViewController;
}

@property (nonatomic, retain) Host *host;
@property (nonatomic, retain) NSFetchedResultsController *hostDatas;
@property (nonatomic, retain) HostDataViewController *hostDataViewController;

-(void)sortServices;
- (void)configureCell:(PluginTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath inBackground:(Boolean)background;
- (void)didSelectHostCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)loadHostDataView:(HostData *)hostData;

@end
