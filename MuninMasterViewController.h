//
//  MuninMasterViewController.h
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MuninMaster.h"

@interface MuninMasterViewController : UITableViewController {
	MuninMaster *muninMaster;
}

@property (nonatomic, retain) MuninMaster *muninMaster;

@end
