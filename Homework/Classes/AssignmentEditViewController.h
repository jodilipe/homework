//
//  AssignmentEditViewController.h
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Assignment;
@class AssignmentTableViewController;


@interface AssignmentEditViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *nameTextField;
	Assignment *assignment;
	AssignmentTableViewController *assignmentTableViewController;
}

@property(nonatomic,retain)Assignment *assignment;
@property(nonatomic,retain)AssignmentTableViewController *assignmentTableViewController;

@end
