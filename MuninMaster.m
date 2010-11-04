// 
//  MuninMaster.m
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MuninMaster.h"
#import "Host.h"
#import "HomePageParser.h"

@implementation MuninMaster 

@dynamic lastSynced;
@dynamic name;
@dynamic url;
@dynamic hosts;

-(Boolean)sync {
	NSURL *url = [[NSURL alloc] initWithString:self.url];
	[[HomePageParser sharedHomePageParser] parse:url];
	
	return YES;
}

@end
