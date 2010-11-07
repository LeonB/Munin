// 
//  Host.m
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "Host.h"

#import "HostService.h"
#import "MuninMaster.h"
#import "HostPageparser.h"
#import "Service.h"

@implementation Host 

@dynamic MuninMasterId;
@dynamic lastSynced;
@dynamic name;
@dynamic url;
@dynamic muninMaster;
@dynamic hostServices;
@dynamic services;

- (Boolean)sync {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSURL *url = [[NSURL alloc] initWithString:self.url];
	Host *host = [[HostPageParser sharedHostPageParser] parse:url];
	
//	self.hostServices = host.hostServices;
//	
//	for (HostService *hostService in host.hostServices) {
//		HostService *newHostService = [NSEntityDescription insertNewObjectForEntityForName:@"HostService" inManagedObjectContext:self.managedObjectContext];
//		newHostService.name = hostService.name;
//		newHostService.url = hostService.url;
//		
//		for (Service *service in ) {
//			<#statements#>
//		}
//		
//		self.hostServices = [self.hostServices setByAddingObject:newHostService];
//	}

	HostService *hostService = [NSEntityDescription insertNewObjectForEntityForName:@"HostService" inManagedObjectContext:self.managedObjectContext];
	Service *service = [NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext:self.managedObjectContext];
	service.name = @"Disk";

	HostService *hostService2 = [NSEntityDescription insertNewObjectForEntityForName:@"HostService" inManagedObjectContext:self.managedObjectContext];
	Service *service2 = [NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext:self.managedObjectContext];
	service2.name = @"Network";
	
	//hostService.host = self;
	hostService.service = service;
	hostService.url =  @"http://munin.ping.uio.no/ping.uio.no/colosseum.ping.uio.no.html#Disk";
	
	//hostService.host = self;
	hostService2.service = service2;
	hostService2.url =  @"http://munin.ping.uio.no/ping.uio.no/colosseum.ping.uio.no.html#Network";	
	
	NSArray *hostServices = [[NSArray alloc] initWithObjects:hostService, hostService2, nil];
	
	self.hostServices = [self.hostServices setByAddingObjectsFromArray:hostServices];
	
	self.lastSynced = [NSDate date];
	
	NSError *error;
	[self.managedObjectContext save:&error];
	
	//NSLog(@"error: %@", error);
	
	[pool drain];
	return YES;
}

@end
