//
//  HomeworkDueTableViewController.m
//  Homework
//
//  Created by Jon Pedersen on 09/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "HomeworkDueTableViewController.h"
#import "HomeworkAppDelegate.h"
#import "Homework.h"


@implementation HomeworkDueTableViewController

@synthesize homework;

-(IBAction)dateChanged {
	homework.due = datePicker.date;
	HomeworkAppDelegate *mainDelegate = (HomeworkAppDelegate*)[[UIApplication sharedApplication]delegate];
	[mainDelegate saveContext];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	[datePicker setDate:homework.due animated:YES];
	self.title = @"Due Date";
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setDateFormat:@"EEE dd MMMM yyyy"]; 
	cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Due %@", "Due date"), [dateFormatter stringFromDate: homework.due]];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// do nada
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[homework release];
}


@end

