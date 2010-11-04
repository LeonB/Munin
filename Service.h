//
//  Service.h
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class HostService;
@class Plugin;

@interface Service :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* plugins;
@property (nonatomic, retain) NSSet* hostServices;

@end


@interface Service (CoreDataGeneratedAccessors)
- (void)addPluginsObject:(Plugin *)value;
- (void)removePluginsObject:(Plugin *)value;
- (void)addPlugins:(NSSet *)value;
- (void)removePlugins:(NSSet *)value;

- (void)addHostServicesObject:(HostService *)value;
- (void)removeHostServicesObject:(HostService *)value;
- (void)addHostServices:(NSSet *)value;
- (void)removeHostServices:(NSSet *)value;

@end

