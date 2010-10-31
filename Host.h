//
//  Host.h
//  Munin
//
//  Created by Leon Bogaert on 31-10-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <CoreData/CoreData.h>

@class MuninMaster;

@interface Host :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * MuninMasterId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* plugins;
@property (nonatomic, retain) MuninMaster * muninMaster;

@end


@interface Host (CoreDataGeneratedAccessors)
- (void)addPluginsObject:(NSManagedObject *)value;
- (void)removePluginsObject:(NSManagedObject *)value;
- (void)addPlugins:(NSSet *)value;
- (void)removePlugins:(NSSet *)value;

@end

