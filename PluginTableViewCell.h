//
//  PluginTableViewCell.h
//  Munin
//
//  Created by Leon Bogaert on 11-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plugin.h"

@interface PluginTableViewCell : UITableViewCell {
	Plugin *plugin;
}

@property (nonatomic, retain) Plugin *plugin;

@end
