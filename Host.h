//
//  Host.h
//  Munin
//
//  Created by Leon Bogaert on 10-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class HostData;
@class MuninMaster;

@interface Host :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * MuninMasterId;
@property (nonatomic, retain) NSDate * lastSynced;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) MuninMaster * muninMaster;
@property (nonatomic, retain) NSSet* hostDatas;
@property (nonatomic, retain) NSFetchedPropertyDescription* plugins;

@end


@interface Host (CoreDataGeneratedAccessors)
- (void)addHostDatasObject:(HostData *)value;
- (void)removeHostDatasObject:(HostData *)value;
- (void)addHostDatas:(NSSet *)value;
- (void)removeHostDatas:(NSSet *)value;

@end

