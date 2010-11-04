//
//  HostTableViewCell.h
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Host.h"

@interface HostTableViewCell : UITableViewCell {
	Host *host;
}

@property (nonatomic, retain) Host *host;

@end
