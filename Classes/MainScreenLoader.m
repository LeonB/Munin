//
//  MainScreenLoader.m
//  ADB2
//
//  Created by Leon Bogaert on 13-6-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "MainScreenLoader.h"
#import "MuninMastersViewController.h"

@implementation MainScreenLoader

+ (MuninMastersViewController *)loadMuninMasters {
	MuninMastersViewController *controller = [[MuninMastersViewController alloc] initWithNibName:@"MuninMastersViewController" bundle:nil];
	return [controller autorelease];
}

@end
