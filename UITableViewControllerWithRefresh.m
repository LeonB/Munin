//
//  UITableViewControllerWithRefresh.m
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "UITableViewControllerWithRefresh.h"
#import "EGORefreshTableHeaderView.h"
#import "SoundEffect.h"

@implementation UITableViewControllerWithRefresh
@synthesize reloading=_reloading;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 320.0f, self.tableView.bounds.size.height)];
		refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		[self.tableView addSubview:refreshHeaderView];
		self.tableView.showsVerticalScrollIndicator = YES;
		[refreshHeaderView release];
	}
	
	// pre-load sounds
	psst1Sound = [[SoundEffect alloc] initWithContentsOfFile:
				  [[NSBundle mainBundle] pathForResource:@"psst1"
												  ofType:@"wav"]];
	psst2Sound  = [[SoundEffect alloc] initWithContentsOfFile:
				   [[NSBundle mainBundle] pathForResource:@"psst2"
												   ofType:@"wav"]];
	popSound  = [[SoundEffect alloc] initWithContentsOfFile:
				 [[NSBundle mainBundle] pathForResource:@"pop"
												 ofType:@"wav"]];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
			[popSound play];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
			[psst1Sound play];
		}
	}
}

- (void)reloadTableViewDataSource {
	//  should be calling your tableviews model to reload
	//  put here just for demo
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (void)doneLoadingTableViewData {
	//  model should call this when its done loading
	[self dataSourceDidFinishLoadingNewData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.contentOffset.y <= - 65.0f && !_reloading) {
		_reloading = YES;
		[self reloadTableViewDataSource];
		[refreshHeaderView setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
		[psst2Sound play];
	}
}

- (void)dataSourceDidFinishLoadingNewData {
	
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful
	[popSound play];

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[psst1Sound release];
	[psst2Sound release];
	[popSound release];	
	refreshHeaderView = nil;
    [super dealloc];
}


@end

