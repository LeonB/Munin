//
//  ServiceTableViewCell.h
//  Munin
//
//  Created by Leon Bogaert on 08-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Service;

@interface ServiceTableViewCell : UITableViewCell {
	Service *service;
}

@property (nonatomic, retain) Service *service;
@end
