//
//  Service.h
//  Munin
//
//  Created by Leon Bogaert on 10-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Plugin;

@interface Service :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* plugins;

@end


@interface Service (CoreDataGeneratedAccessors)
- (void)addPluginsObject:(Plugin *)value;
- (void)removePluginsObject:(Plugin *)value;
- (void)addPlugins:(NSSet *)value;
- (void)removePlugins:(NSSet *)value;

@end

