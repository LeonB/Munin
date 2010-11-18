//
//  HostDataTableViewCell.h
//  Munin
//
//  Created by Leon Bogaert on 14-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HostData.h"

@interface HostDataTableViewCell : UITableViewCell {
	HostData *hostData;
}

@property (nonatomic, retain) HostData *hostData;

@end
