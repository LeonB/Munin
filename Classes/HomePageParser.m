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

- (void)parse {
	MuninAppDelegate *appDelegate = APPDELEGATE;
	NSManagedObjectContext *managedObjectContext = [[appDelegate managedObjectContext] retain];
	
	//MuninMaster *muninMaster = [NSEntityDescription insertNewObjectForEntityForName:@"MuninMaster" inManagedObjectContext:managedObjectContext];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	//fetchRequest.entity = [muninMaster entity];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"MuninMaster" inManagedObjectContext:managedObjectContext]];
	
	NSPredicate *predicate = [NSPredicate
							  predicateWithFormat:@"name=%@", @"munin.ping.uio.no"];
	[fetchRequest setPredicate:predicate];
	
	NSError *error;
	NSArray *items = [managedObjectContext
					  executeFetchRequest:fetchRequest error:&error];
	
	MuninMaster *muninMaster = [items objectAtIndex:0];
	[fetchRequest release]; 
	
	NSLog(@"Starting download webpage");
	
	NSError *err = [[[NSError alloc] init] autorelease];
	NSString *url = [[NSString stringWithString:muninMaster.url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *source = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&err];
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
			
			Host *host = [NSEntityDescription insertNewObjectForEntityForName:@"Host" inManagedObjectContext:managedObjectContext];
			host.name = hostElement.contentsText;
			host.url = [[hostElement selectElement: @"a"] attribute:@"href"];
			
			NSArray *serviceElements = [(Element *)[hostElement parent] selectElements: @"li a"];
			for (Element *serviceElement in serviceElements) {
				//NSLog(@"serviceElement: %@", serviceElement);
				//NSLog(@"service: %@", serviceElement.contentsText);
				
				Service *service = [NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext:managedObjectContext];
				service.name = serviceElement.contentsText;
				
				HostService *hostService = [NSEntityDescription insertNewObjectForEntityForName:@"HostService" inManagedObjectContext:managedObjectContext];
				hostService.url = [[serviceElement selectElement: @"a"] attribute:@"href"];
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
}

@end
