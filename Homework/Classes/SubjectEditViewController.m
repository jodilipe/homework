//
//  SubjectEditViewController.m
//  Homework
//
//  Created by Jon Pedersen on 13/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "SubjectEditViewController.h"
#import "SubjectTableViewController.h"
#import "Subject.h"


@implementation SubjectEditViewController

@synthesize subject;
@synthesize subjectTableViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[nameTextField becomeFirstResponder];
	if (subject.name) {
		nameTextField.text = subject.name;
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	if ([nameTextField.text length] > 0) {
		subject.name = nameTextField.text;
		[subjectTableViewController saveContext];
	} else {
		[subjectTableViewController delete:subject];
	}
	[[subjectTableViewController tableView] reloadData];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
	[nameTextField resignFirstResponder]; 
	return YES;
}

#pragma mark -
#pragma mark Memory stuff

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[subject release];
}


@end
