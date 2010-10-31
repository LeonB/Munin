//
//  MuninMasterTableViewCell.h
//  Munin
//
//  Created by Leon Bogaert on 31-10-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MuninMaster.h"

@interface MuninMasterTableViewCell : UITableViewCell {
	MuninMaster *muninMaster;
}

@property (nonatomic, retain) MuninMaster *muninMaster;

@end
