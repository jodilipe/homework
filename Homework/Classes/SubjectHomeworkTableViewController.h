//
//  SubjectHomeworkTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 13/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Subject;


@interface SubjectHomeworkTableViewController : UITableViewController {
	Subject *subject;
	NSArray *homeworks;
}

@property(nonatomic,retain)Subject *subject;
@property(nonatomic,retain)NSArray *homeworks;
@end
