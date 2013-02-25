//
//  HomeworkDetailTableViewController.m
//  Homework
//
//  Created by Jon Pedersen on 09/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "HomeworkDetailTableViewController.h"
#import "HomeworkDueTableViewController.h"
#import "HomeworkSubjectTableViewController.h"
#import "HomeworkAssignmentTableViewController.h"
#import "HomeworkNoteViewController.h"
#import "HomeworkDeliveredTableViewController.h"
#import "Homework.h"
#import "Subject.h"
#import "Assignment.h"


@implementation HomeworkDetailTableViewController

@synthesize homework;
@synthesize rootViewController;


#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"title";
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
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
	if (indexPath.section == 0) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat:@"EEE dd MMMM yyyy"]; 
		cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Due %@", "Due date"), [dateFormatter stringFromDate: homework.due]];
		[dateFormatter release];
	} else if (indexPath.section == 1) {
		if (homework.subject) {
			cell.textLabel.text = homework.subject.name;
		} else {
			cell.textLabel.text = NSLocalizedString(@"(subject)", "Homework subject");
		}
	} else if (indexPath.section == 2) {
		if (homework.assignment) {
			cell.textLabel.text = homework.assignment.name;
		} else {
			cell.textLabel.text = NSLocalizedString(@"(assignment)", "Homework assignment");
		}

	} else if (indexPath.section == 3) {
		cell.textLabel.numberOfLines = 5;
		if (homework.note) {
			cell.textLabel.text = homework.note;
		} else {
			cell.textLabel.text = NSLocalizedString(@"(note)", "Note nil value");
		}
	} else if (indexPath.section == 4) {
		if (homework.delivered) {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
            [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
            [dateFormatter setDateFormat:@"EEE dd MMMM yyyy"]; 
			cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Delivered %@", "Delivered date"), [dateFormatter stringFromDate: homework.delivered]];
			[dateFormatter release];
		} else {
			cell.textLabel.text = NSLocalizedString(@"(delivered)", "Delivered nil value");
		}
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 3) {
		return 115;
	} else {
		return 35;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		HomeworkDueTableViewController *homeworkDueTableViewController = [[HomeworkDueTableViewController alloc] initWithNibName:@"HomeworkDueTableViewController" bundle:nil];
		homeworkDueTableViewController.homework = homework;
		[self.navigationController pushViewController:homeworkDueTableViewController animated:YES];
		[homeworkDueTableViewController release];
	} else if (indexPath.section == 1) {
		HomeworkSubjectTableViewController *homeworkSubjectTableViewController = [[HomeworkSubjectTableViewController alloc] initWithNibName:@"HomeworkSubjectTableViewController" bundle:nil];
		homeworkSubjectTableViewController.homework = homework;
		[self.navigationController pushViewController:homeworkSubjectTableViewController animated:YES];
		[homeworkSubjectTableViewController release];
	} else if (indexPath.section == 2) {
		HomeworkAssignmentTableViewController *homeworkAssignmentTableViewController = [[HomeworkAssignmentTableViewController alloc] initWithNibName:@"HomeworkAssignmentTableViewController" bundle:nil];
		homeworkAssignmentTableViewController.homework = homework;
		[self.navigationController pushViewController:homeworkAssignmentTableViewController animated:YES];
		[homeworkAssignmentTableViewController release];
	} else if (indexPath.section == 3) {
		HomeworkNoteViewController *homeworkNoteViewController = [[HomeworkNoteViewController alloc] initWithNibName:@"HomeworkNoteViewController" bundle:nil];
		homeworkNoteViewController.homework = homework;
		[self.navigationController pushViewController:homeworkNoteViewController animated:YES];
		[homeworkNoteViewController release];
	} else if (indexPath.section == 4) {
		HomeworkDeliveredTableViewController *homeworkDeliveredTableViewController = [[HomeworkDeliveredTableViewController alloc] initWithNibName:@"HomeworkDeliveredTableViewController" bundle:nil];
		homeworkDeliveredTableViewController.homework = homework;
		[self.navigationController pushViewController:homeworkDeliveredTableViewController animated:YES];
		[homeworkDeliveredTableViewController release];
	}
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
	[rootViewController release];
}


@end

