//
//  NSSingleton.h
//  TCCALC
//
//  Created by Jean-Luc on 12/05/08.
//

//http://www.devbypractice.com/reusable-singleton-class-in-objective-c-for-iphone-and-ipad/

#import <Foundation/NSObject.h>

@interface NSSingleton : NSObject {
}

+(void)cleanup;
// Deux cas:
// . [NSSingleton cleanup]  : Free all singletons.
// . [MySingleton cleanup] : Free MySingleton.

+(id)sharedInstance;
// Notes :
// . +(id)sharedInstance can be overridden to return the right type..
//   ex : (MySingleton *)sharedInstance { return [super sharedInstance]; }
// . Singleton initialization must be done as usual in -(id)init.
//
@end
