//
//  Plugin.h
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Service;

@interface Plugin :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Service * service;

@end



