//
//  HomePageParser.m
//  Munin
//
//  Created by Leon Bogaert on 03-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "HomePageParser.h"
#import "SynthesizeSingleton.h"
#import "Element.h"
#import "MuninMaster.h"
#import "Host.h"
#import "HostService.h"
#import "Service.h"
#import "MuninAppDelegate.h"

@implementation HomePageParser
SYNTHESIZE_SINGLETON_FOR_CLASS(HomePageParser);

/**
 *@Todo: even kijken of ik een callback kan maken zodat de cellen dynamisch verschijnen
**/

- (MuninMaster *)parse:(NSURL *)url {
	MuninAppDelegate *appDelegate = APPDELEGATE;
	NSManagedObjectContext *managedObjectContext = [[[NSManagedObjectContext alloc] init] autorelease];
	[managedObjectContext setPersistentStoreCoordinator:appDelegate.persistentStoreCoordinator];
	MuninMaster *muninMaster = [NSEntityDescription insertNewObjectForEntityForName:@"MuninMaster" inManagedObjectContext:managedObjectContext];
	
	NSLog(@"Starting download webpage");
	
	NSError *err = [[[NSError alloc] init] autorelease];
	//NSString *url = [[NSString stringWithString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
	if(err.code != 0) {
		//HANDLE ERROR HERE
	}
	
	NSLog(@"Downloaded website");
	
	DocumentRoot *document = [Element parseHTML:source];
	NSArray *domainElements = [(Element *)document selectElements: @"li span.domain"];
	
	for (Element *domainElement in domainElements) {
		//NSLog(@"domainElement: %@", domainElement);
		//NSLog(@"domain: %@", domainElement.contentsText);
		
		NSArray *hostElements = [(Element *)[domainElement parent] selectElements: @"span.host"];
		for (Element *hostElement in hostElements) {
			//NSLog(@"hostElement: %@", hostElement);
			//NSLog(@"host: %@", hostElement.contentsText);
			
			NSString *base = [NSString stringWithFormat:@"%@", url];
			NSString *path = [[hostElement selectElement: @"a"] attribute:@"href"];
			
			Host *host = [NSEntityDescription insertNewObjectForEntityForName:@"Host" inManagedObjectContext:managedObjectContext];
			host.name = hostElement.contentsText;
			host.url = [NSString stringWithFormat:@"%@/%@", base, path];
			
			NSArray *serviceElements = [(Element *)[hostElement parent] selectElements: @"li a"];
			for (Element *serviceElement in serviceElements) {
				//NSLog(@"serviceElement: %@", serviceElement);
				//NSLog(@"service: %@", serviceElement.contentsText);
				
				Service *service = [NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext:managedObjectContext];
				service.name = serviceElement.contentsText;
				
				HostService *hostService = [NSEntityDescription insertNewObjectForEntityForName:@"HostService" inManagedObjectContext:managedObjectContext];
				
				NSString *base = [NSString stringWithFormat:@"%@", url];
				NSString *path = [[serviceElement selectElement: @"a"] attribute:@"href"];
				
				hostService.url = [NSString stringWithFormat:@"%@/%@", base, path];
				hostService.host = host;
				hostService.service = service;
			}
			//NSLog(@"host: %@", host);
			[muninMaster addHostsObject:host];
		}
	}
	
	NSLog(@"muninMaster: %@", muninMaster);
	
//	if (![managedObjectContext save:&error]) {
//		NSLog(@"url: %@", muninMaster.url);
//		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//		NSLog(@"error: %@", error);
//	}
	
	//[managedObjectContext release];
	//[err release];
	
	return muninMaster;
}

@end
