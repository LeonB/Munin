// 
//  Host.m
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Host.h"

#import "HostService.h"
#import "MuninMaster.h"

@implementation Host 

@dynamic MuninMasterId;
@dynamic lastSynced;
@dynamic name;
@dynamic url;
@dynamic muninMaster;
@dynamic hostServices;

@end
