//
//  MuninMaster.h
//  Munin
//
//  Created by Leon Bogaert on 31-10-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Host;

@interface MuninMaster :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet* hosts;

@end


@interface MuninMaster (CoreDataGeneratedAccessors)
- (void)addHostsObject:(Host *)value;
- (void)removeHostsObject:(Host *)value;
- (void)addHosts:(NSSet *)value;
- (void)removeHosts:(NSSet *)value;

@end

