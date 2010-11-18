//
//  HostData.h
//  Munin
//
//  Created by Leon Bogaert on 10-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Host;
@class Plugin;
@class Service;

@interface HostData :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Plugin * plugin;
@property (nonatomic, retain) Host * host;
//@property (nonatomic, retain) Service* service;

@end



