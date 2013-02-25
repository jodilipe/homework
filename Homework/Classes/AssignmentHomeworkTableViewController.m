//
//  AssignmentHomeworkTableViewController.m
//  Homework
//
//  Created by Jon Pedersen on 07/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "AssignmentHomeworkTableViewController.h"
#import "HomeworkDetailTableViewController.h"
#import "HomeworkAppDelegate.h"
#import "Homework.h"
#import "Subject.h"
#import "Assignment.h"
#import "HomeworkUtil.h"


@implementation AssignmentHomeworkTableViewController

@synthesize assignment;
@synthesize homeworks;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	NSMutableArray *temp = [NSMutableArray array]; 
	for (Homework *currHomework in assignment.homeworks) {
		[temp addObject:currHomework];
	}
	NSSortDescriptor *deliveredSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"delivered" ascending:YES] autorelease];
	NSSortDescriptor *dueSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"due" ascending:YES] autorelease];
	NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:deliveredSortDescriptor, dueSortDescriptor, nil] autorelease];
	self.homeworks = [temp sortedArrayUsingDescriptors:sortDescriptors];
	self.title = NSLocalizedString(@"Homework", "Homework title");
	[self.tableView reloadData];
}

#pragma mark - 
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [homeworks count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Homework *homework = [homeworks objectAtIndex:indexPath.row];
    if (homework.note) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", homework.assignment.name, homework.subject.name, homework.note];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", homework.assignment.name, homework.subject.name];
    }
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setDateFormat:@"EEE dd MMMM yyyy"]; 
	if (homework.delivered) {
		cell.textLabel.textColor = [UIColor grayColor];
		cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Delivered %@", "Delivered date"), [dateFormatter stringFromDate: homework.delivered]];
		cell.detailTextLabel.textColor = [UIColor grayColor];
	} else {
		cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Due %@", "Due date"), [dateFormatter stringFromDate: homework.due]];
		cell.detailTextLabel.textColor = [HomeworkUtil getColor:homework.due];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	[dateFormatter release];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	HomeworkDetailTableViewController *homeworkDetailTableViewController = [[HomeworkDetailTableViewController alloc] initWithNibName:@"HomeworkDetailTableViewController" bundle:nil];
	homeworkDetailTableViewController.homework = [homeworks objectAtIndex:indexPath.row];
	HomeworkAppDelegate *mainDelegate = (HomeworkAppDelegate*)[[UIApplication sharedApplication]delegate];
	homeworkDetailTableViewController.rootViewController = [mainDelegate rootViewController];
	homeworkDetailTableViewController.title = NSLocalizedString(@"Edit homework", "Edit homework title");
	[self.navigationController pushViewController:homeworkDetailTableViewController animated:YES];
	[homeworkDetailTableViewController release];
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
	[homeworks release];
}


@end

