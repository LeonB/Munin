//
//  HostPageParser.m
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "HostPageParser.h"
#import "SynthesizeSingleton.h"
#import "Host.h"
#import "MuninAppDelegate.h"
#import "Element.h"
#import "Service.h"
#import "Plugin.h"
#import "HostService.h"

@implementation HostPageParser
SYNTHESIZE_SINGLETON_FOR_CLASS(HostPageParser);

- (Host *)parse:(NSURL *)url {
	MuninAppDelegate *appDelegate = APPDELEGATE;
	NSManagedObjectContext *managedObjectContext = [[[NSManagedObjectContext alloc] init] autorelease];
	[managedObjectContext setPersistentStoreCoordinator:appDelegate.persistentStoreCoordinator];
	
	Host *host = [NSEntityDescription insertNewObjectForEntityForName:@"Host" inManagedObjectContext:managedObjectContext];
	host.url = [NSString stringWithFormat:@"%@", url];
	
	NSLog(@"Starting download webpage");
	
	NSError *err = [[[NSError alloc] init] autorelease];
	NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
	if(err.code != 0) {
		//HANDLE ERROR HERE
	}
	
	NSLog(@"Downloaded website: %@", url);
	
	DocumentRoot *document = [Element parseHTML:source];
	NSArray *serviceElements = [(Element *)document selectElements: @"h3"];
	for (Element *serviceElement in serviceElements) {
		Service *service = [NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext:managedObjectContext];
		service.name = serviceElement.contentsText;
		
		HostService *hostService = [NSEntityDescription insertNewObjectForEntityForName:@"HostService" inManagedObjectContext:managedObjectContext];
		hostService.host = host;
		hostService.service = service;
		
//		NSLog(@"service: %@", service);

		Element *parent = [[[serviceElement parent] parent] parent];
		NSArray *pluginElements = [parent selectElements: @".lighttext a"];
		for (Element *pluginElement in pluginElements) {

			NSString *base = [NSString stringWithFormat:@"%@", url];
			NSString *path = [pluginElement attribute:@"href"];
			
			Plugin *plugin = [NSEntityDescription insertNewObjectForEntityForName:@"Plugin" inManagedObjectContext:managedObjectContext];
			plugin.name = pluginElement.contentsText;
			plugin.url = [NSString stringWithFormat:@"%@/%@", base, path];
			plugin.service = service;
			
//			NSLog(@"plugin: %@", plugin);
		}
	}
	//NSLog(@"host: %@", host);
	//NSLog(@"[host valueForKey:@\"services\"]: %@", [host valueForKey:@"services"]);
	
	return host;
}
@end
