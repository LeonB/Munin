//
//  HomePageParser.h
//  Munin
//
//  Created by Leon Bogaert on 03-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "MuninMaster.h"

@interface HomePageParser : NSObject {

}

+ (HomePageParser *)sharedHomePageParser;
- (MuninMaster *)parse:(NSURL *)url;

@end
