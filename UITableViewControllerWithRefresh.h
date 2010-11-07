//
//  UITableViewControllerWithRefresh.h
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGORefreshTableHeaderView;
@class SoundEffect;

@interface UITableViewControllerWithRefresh : UITableViewController {
	EGORefreshTableHeaderView *refreshHeaderView;

	//  Reloading should really be your tableviews model class
	//  Putting it here for demo purposes 
	BOOL _reloading;
	
	SoundEffect *psst1Sound;
	SoundEffect *psst2Sound;
	SoundEffect *popSound;	
}

@property(assign,getter=isReloading) BOOL reloading;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)dataSourceDidFinishLoadingNewData;

@end
