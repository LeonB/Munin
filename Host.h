//
//  Host.h
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class HostService;
@class MuninMaster;

@interface Host :  NSManagedObject
{
}

@property (nonatomic, retain) NSNumber * MuninMasterId;
@property (nonatomic, retain) NSDate * lastSynced;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) MuninMaster * muninMaster;
@property (nonatomic, retain) NSSet* hostServices;
@property (nonatomic, retain) NSArray* services;

@end


@interface Host (CoreDataGeneratedAccessors)
- (void)addHostServicesObject:(HostService *)value;
- (void)removeHostServicesObject:(HostService *)value;
- (void)addHostServices:(NSSet *)value;
- (void)removeHostServices:(NSSet *)value;

@end

