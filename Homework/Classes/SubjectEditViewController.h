//
//  SubjectEditViewController.h
//  Homework
//
//  Created by Jon Pedersen on 13/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Subject;
@class SubjectTableViewController;


@interface SubjectEditViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *nameTextField;
	Subject *subject;
	SubjectTableViewController *subjectTableViewController;
}

@property(nonatomic,retain)Subject *subject;
@property(nonatomic,retain)SubjectTableViewController *subjectTableViewController;

@end
