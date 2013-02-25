//
//  AssignmentHomeworkTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 07/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Assignment;


@interface AssignmentHomeworkTableViewController : UITableViewController {
	Assignment *assignment;
	NSArray *homeworks;
}

@property(nonatomic,retain)Assignment *assignment;
@property(nonatomic,retain)NSArray *homeworks;
@end
