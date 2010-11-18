// 
//  Host.m
//  Munin
//
//  Created by Leon Bogaert on 10-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Host.h"

#import "HostData.h"
#import "MuninMaster.h"
#import "HostPageParser.h"
#import "HostData.h"
#import "Plugin.h"
#import "Service.h"

@implementation Host 

@dynamic MuninMasterId;
@dynamic lastSynced;
@dynamic name;
@dynamic url;
@dynamic muninMaster;
@dynamic hostDatas;
@dynamic plugins;

- (Boolean)sync {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSURL *url = [[NSURL alloc] initWithString:self.url];
	Host *host = [[HostPageParser sharedHostPageParser] parse:url];
	
	NSError *error;
	
	NSDictionary *servicesToImport = [[NSMutableDictionary alloc] init];
	
//	NSDictionary *hostsDatasToImport = [[NSMutableDictionary alloc] init];
//	NSDictionary *pluginsToImport = [[NSMutableDictionary alloc] init];
	
	for (HostData *hostData in host.hostDatas) {
		NSMutableDictionary *serviceDict = [[NSMutableDictionary alloc] init];
		[serviceDict setValue:hostData.plugin.service.name forKey:@"name"];
		
		[servicesToImport setValue:serviceDict forKey:[serviceDict objectForKey:@"name"]];
		[serviceDict release];
	}

	 NSDictionary *importedServices = [self.managedObjectContext updateEntity: @"Service"
							  fromDictionary: servicesToImport
							  withIdentifier: @"name"
								 overwriting: [NSArray arrayWithObject:@"name"]
										andError: &error];
	
	NSDictionary *pluginsToImport = [[NSMutableDictionary alloc] init];
	for (HostData *hostData in host.hostDatas) {
		NSMutableDictionary *pluginDict = [[NSMutableDictionary alloc] init];
		[pluginDict setValue:hostData.plugin.name forKey:@"name"];
		[pluginDict setValue:hostData.plugin.url forKey:@"url"];

		Service *service = [importedServices objectForKey:hostData.plugin.service.name];
		[pluginDict setValue:service forKey:@"service"];
		
		[pluginsToImport setValue:pluginDict forKey:[pluginDict objectForKey:@"name"]];
		[pluginDict release];
	}
	
	NSDictionary *importedPlugins = [self.managedObjectContext updateEntity: @"Plugin"
															  fromDictionary: pluginsToImport
															  withIdentifier: @"name"
																overwriting: [NSArray arrayWithObjects:@"name", @"url", nil]
																	andError: &error];
	
	//NSLog(@"importedPlugins: %@", importedPlugins);
	
	NSDictionary *hostDatasToImport = [[NSMutableDictionary alloc] init];
	for (HostData *hostData in host.hostDatas) {
		NSMutableDictionary *hostDatasDict = [[NSMutableDictionary alloc] init];
		[hostDatasDict setValue:hostData.url forKey:@"url"];
		
		Plugin *plugin = [importedPlugins objectForKey:hostData.plugin.name];
		[hostDatasDict setValue:plugin forKey:@"plugin"];
			
		//NSLog(@"hostDatasDict: %@", hostDatasDict);
		
		//[hostDatasToImport setValue:hostDatasDict forKey:[hostDatasDict objectForKey:@"plugin"]];
		[hostDatasToImport setValue:hostDatasDict forKey:[NSString stringWithFormat:@"%@", plugin.objectID]];
		[hostDatasDict release];
	}
//	
//	NSDictionary *importedHostDatas = [self.managedObjectContext updateEntity: @"HostData"
//															 fromDictionary: hostDatasToImport
//															 withIdentifier: @"plugin"
//																overwriting: nil
//																   andError: &error];
//	
//	NSLog(@"importedHostDatas: %@", importedHostDatas);
	
	NSMutableDictionary *importedHostDatas = [[NSMutableDictionary alloc] init];
	for (NSString *newHostDataIdentifier in [hostDatasToImport allKeys]) {
		NSDictionary *hostDatasDict = [hostDatasToImport objectForKey:newHostDataIdentifier];
		
		BOOL found = NO;
		for (HostData *hostData in self.hostDatas) {
			NSString *hostDataIdentifier = [NSString stringWithFormat:@"%@", hostData.plugin.objectID];
			if ([hostDataIdentifier isEqual:newHostDataIdentifier]) {
				found = YES;
			}
		}
		
		if (found == NO) {
			HostData *hostData = [NSEntityDescription insertNewObjectForEntityForName:@"HostData" inManagedObjectContext:self.managedObjectContext];
			hostData.url = [hostDatasDict objectForKey:@"url"];
			hostData.host = self;
			hostData.plugin = [hostDatasDict objectForKey:@"plugin"];
			//NSLog(@"hostData.service: %@", hostData.service);
			//NSLog(@"hostData.plugin: %@", hostData.plugin);
		}
	}
	
	//importedHostDatas gebruiken om te verwijderen
	//withIdentifier: multiple mogelijk maken (*)
	//Eventueel met een NSArray?

	//NSLog(@"self: %@", self);
	
	//[self.managedObjectContext save:&error];
	//NSLog(@"error: %@", error);
	
	self.lastSynced = [NSDate date];
	
	[pool drain];
	return YES;
}

@end
