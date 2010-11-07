// 
//  MuninMaster.m
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "MuninMaster.h"
#import "Host.h"
#import "HomePageParser.h"
#import "NSManagedObjectContext_UpdateEntity.h"
#import "MuninAppDelegate.h"

@implementation MuninMaster 

@dynamic lastSynced;
@dynamic name;
@dynamic url;
@dynamic hosts;

-(Boolean)sync {
	NSURL *url = [[NSURL alloc] initWithString:self.url];
	MuninMaster *muninMaster = [[HomePageParser sharedHomePageParser] parse:url];
	
	//NSDictionary *hostsToImport = [[muninMaster.hosts allObjects] indexKeyedDictionary];
	NSDictionary *hostsToImport = [[NSMutableDictionary alloc] init];
	NSLog(@"objectId: %@", [self objectID]);
	for (Host *host in muninMaster.hosts) {
		//[[host setMuninMasterId:[NSNumber alloc] initWi]];
		NSMutableDictionary *hostDict = [[NSMutableDictionary alloc] init];
		[hostDict setValue:host.name forKey:@"name"];
		[hostDict setValue:host.url forKey:@"url"];
		[hostDict setValue:self forKey:@"muninMaster"];
		
		[hostsToImport setValue:hostDict forKey:host.name];
	}
	
	//NSLog(@"hostsToImport: %@", hostsToImport);
	
	/**
	 *@TODO: Hier moet nog een subset aan meegegeven worden anders worden hosts van anderen muninMasters weggegooid
	**/
	NSError *error;
	[self.managedObjectContext updateEntity: @"Host"
						  fromDictionary: hostsToImport
						  withIdentifier: @"name"
							 overwriting: [NSArray arrayWithObject:@"name"]
								andError: &error];
	
	self.lastSynced = [NSDate date];
	[self.managedObjectContext processPendingChanges];
	
	return YES;
}

//-(void)setHosts:(NSSet *)newHosts {
//	
//}

@end
