//
//  HostService.h
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Host;
@class Service;

@interface HostService :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Service * service;
@property (nonatomic, retain) Host * host;

@end



