//
//  HostDataViewController.h
//  Munin
//
//  Created by Leon Bogaert on 14-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HostData.h"

@interface HostDataViewController : UIViewController {
	HostData *hostData;
}

@property (nonatomic, retain) HostData *hostData;

@end
