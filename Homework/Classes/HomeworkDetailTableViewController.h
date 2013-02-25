//
//  HomeworkDetailTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 09/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Homework;
@class RootViewController;

@interface HomeworkDetailTableViewController : UITableViewController {
	Homework *homework;
	RootViewController *rootViewController;
}

@property(nonatomic,retain)Homework *homework;
@property(nonatomic,retain)RootViewController *rootViewController;

@end
