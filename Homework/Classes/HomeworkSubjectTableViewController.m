//
//  HomeworkSubjectTableViewController.m
//  Homework
//
//  Created by Jon Pedersen on 09/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "HomeworkSubjectTableViewController.h"
#import "Homework.h"
#import "Subject.h"
#import "HomeworkAppDelegate.h"


@implementation HomeworkSubjectTableViewController

@synthesize homework;
@synthesize subjects;

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	HomeworkAppDelegate *mainDelegate = (HomeworkAppDelegate*)[[UIApplication sharedApplication]delegate];
	self.subjects = [mainDelegate fetchSubjects];
    int index = 0;
    if (homework.subject) {
        index = [subjects indexOfObject:homework.subject];
    } else {
        homework.subject = [subjects objectAtIndex:index];
    }
	[pickerView selectRow: index inComponent: 0 animated:NO];
	self.title = NSLocalizedString(@"Subject", "Subject title");
}

- (void)viewWillDisappear:(BOOL)animated {
	self.homework.subject = [subjects objectAtIndex:[pickerView selectedRowInComponent:0]];
	HomeworkAppDelegate *mainDelegate = (HomeworkAppDelegate*)[[UIApplication sharedApplication]delegate];
	[mainDelegate saveContext];
}

#pragma mark -
#pragma mark Picker view delegate

- (void)pickerView:(UIPickerView *)id didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	self.homework.subject = [subjects objectAtIndex:[pickerView selectedRowInComponent:0]];
	HomeworkAppDelegate *mainDelegate = (HomeworkAppDelegate*)[[UIApplication sharedApplication]delegate];
	[mainDelegate saveContext];
	[self.tableView reloadData];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { 
	return [[subjects objectAtIndex:row] name];
}

#pragma mark -
#pragma mark Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [subjects count];
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
    cell.textLabel.text = homework.subject.name;
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
	[subjects release];
}


@end

