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

@interface HostViewController : UITableViewControllerWithRefresh <NSFetchedResultsControllerDelegate> {
	Host *host;
	NSFetchedResultsController *plugins;
}

@property (nonatomic, retain) Host *host;
@property (nonatomic, retain) NSFetchedResultsController *plugins;

-(void)sortServices;

@end
