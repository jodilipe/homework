//
//  AssignmentEditViewController.m
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "AssignmentEditViewController.h"
#import "AssignmentTableViewController.h"
#import "Assignment.h"


@implementation AssignmentEditViewController

@synthesize assignment;
@synthesize assignmentTableViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[nameTextField becomeFirstResponder];
	if (assignment.name) {
		nameTextField.text = assignment.name;
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	if ([nameTextField.text length] > 0) {
		assignment.name = nameTextField.text;
		[assignmentTableViewController saveContext];
	} else {
		[assignmentTableViewController delete:assignment];
	}
	[[assignmentTableViewController tableView] reloadData];
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
	[assignment release];
}


@end
