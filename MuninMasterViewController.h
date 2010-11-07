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

@interface MuninMasterViewController : UITableViewControllerWithRefresh <NSFetchedResultsControllerDelegate> {
	MuninMaster *muninMaster;
	NSArray *hosts;
}

@property (nonatomic, retain) MuninMaster *muninMaster;
@property (nonatomic, retain) NSArray *hosts;

- (void)configureCell:(HostTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
