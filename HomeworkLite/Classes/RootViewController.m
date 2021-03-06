//
//  RootViewController.m
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "RootViewController.h"
#import "Homework.h"
#import "Assignment.h"
#import "Subject.h"
#import "HomeworkDetailTableViewController.h"
#import "HomeworkUtil.h"


@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)layoutForCurrentOrientation:(BOOL)animated;
-(void)createADBannerView;
@end


@implementation RootViewController

@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;
@synthesize tv;
@synthesize contentView, banner;


- (void)saveContext {
	// Save the context.
	NSError *error = nil;
	if (![[self.fetchedResultsController managedObjectContext] save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//		abort();
	}
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    if(banner == nil) {
        [self createADBannerView];
    }
    [self layoutForCurrentOrientation:NO];

    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(editNewHomework)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
}


// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self layoutForCurrentOrientation:NO];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Homework *homework = [self.fetchedResultsController objectAtIndexPath:indexPath];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setDateFormat:@"EEE dd MMMM yyyy"]; 
	if (!homework.delivered) {
		cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Due %@", "Due date"), [dateFormatter stringFromDate: homework.due]];
		cell.textLabel.textColor = [HomeworkUtil getColor:homework.due];
	} else {
		cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Delivered %@", "Delivered date"), [dateFormatter stringFromDate: homework.delivered]];
		cell.textLabel.textColor = [UIColor grayColor];
	}

	NSString *subjectText;
	if (homework.subject) {
		subjectText = homework.subject.name;
	} else {
		subjectText = NSLocalizedString(@"(subject)", "Homework subject");
	}
	NSString *assignmentText;
	if (homework.assignment) {
		assignmentText = homework.assignment.name;
	} else {
		assignmentText = NSLocalizedString(@"(assignment)", "Homework assignment");
	}
	if (homework.note) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", subjectText, assignmentText, homework.note];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", subjectText, assignmentText];
    }
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//	cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
	[dateFormatter release];
}


#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject {
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    Homework *homework = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    homework.due = [NSDate date];
    // If appropriate, configure the new managed object.
//    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
    }
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {

    // Prevent new objects being added when in editing mode.
    [super setEditing:(BOOL)editing animated:(BOOL)animated];
    self.navigationItem.rightBarButtonItem.enabled = !editing;
    [self.tv setEditing:editing animated:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
        }
    }   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Edit Homework

- (void)delete:(NSManagedObject*) managedObject {
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	[context deleteObject:managedObject];
	[self saveContext];
}

- (void)pushEditViewController:(Homework *) homework withTitle:(NSString *)title {
	HomeworkDetailTableViewController *homeworkDetailTableViewController = [[HomeworkDetailTableViewController alloc] initWithNibName:@"HomeworkDetailTableViewController" bundle:nil];
	homeworkDetailTableViewController.homework = homework;
	homeworkDetailTableViewController.rootViewController = self;
	homeworkDetailTableViewController.title = title;
	[self.navigationController pushViewController:homeworkDetailTableViewController animated:YES];
	[homeworkDetailTableViewController release];
}

- (Homework *)createNewHomework {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    Homework *homework = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
	homework.due = [NSDate date];
	return homework;
}

- (void)editNewHomework {
    if ([self.fetchedResultsController.fetchedObjects count] >= 20) {
		NSString *clearTitle = NSLocalizedString(@"Maximum number of homework entries exceeded",@"Max exceeded title");
		NSString *clearMessage = NSLocalizedString(@"Delete/Edit existing homework entries or buy the full, Add free Version and get unlimited number of homework entries",@"Buy full version");
		NSString *clearOK = NSLocalizedString(@"Dismiss",@"OK action");
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:clearTitle message:clearMessage
													   delegate:self cancelButtonTitle:clearOK otherButtonTitles:nil];
		[alert show];
		[alert release];
    } else {
        [self pushEditViewController:[self createNewHomework] withTitle:NSLocalizedString(@"New homework", "New homework title")];
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Homework *homework = [self.fetchedResultsController objectAtIndexPath:indexPath];
	[self pushEditViewController:homework withTitle:NSLocalizedString(@"Edit homework", "Edit homework title")];
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
    
    /*
     Set up the fetched results controller.
    */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Homework" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *deliveredSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"delivered" ascending:YES];
    NSSortDescriptor *dueSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"due" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:deliveredSortDescriptor, dueSortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [deliveredSortDescriptor release];
    [dueSortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
    }
    
    return fetchedResultsController_;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tv beginUpdates]; 
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tv insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tv deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tv;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tv endUpdates];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    self.contentView = nil;
    banner.delegate = nil;
    self.banner = nil;
}


- (void)dealloc {
    [contentView release]; contentView = nil;
    banner.delegate = nil;
    [banner release]; banner = nil; 
    [fetchedResultsController_ release];
    [managedObjectContext_ release];
    [super dealloc];
}



#pragma mark -
#pragma mark iAdd stuff

-(void)createADBannerView {
	NSString *contentSize;
	contentSize = ADBannerContentSizeIdentifierPortrait;
	
    CGRect frame;
    frame.size = [ADBannerView sizeFromBannerContentSizeIdentifier:contentSize];
    frame.origin = CGPointMake(0.0f, CGRectGetMaxY(self.view.bounds));
    
    ADBannerView *bannerView = [[ADBannerView alloc] initWithFrame:frame];
    bannerView.delegate = self;
    bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    bannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, nil];
    
    [self.view addSubview:bannerView];
    self.banner = bannerView;
    [bannerView release];
}

-(void)layoutForCurrentOrientation:(BOOL)animated {
    CGFloat animationDuration = animated ? 0.2f : 0.0f;
    CGRect contentFrame = self.view.bounds;
	CGPoint bannerOrigin = CGPointMake(CGRectGetMinX(contentFrame), CGRectGetMaxY(contentFrame));
    CGFloat bannerHeight = 0.0f;
    
    CGRect tableFrame = self.tv.frame;
    CGFloat fullViewHeight = self.view.frame.size.height;
    
    banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;

    bannerHeight = banner.bounds.size.height; 
	
    if(banner.bannerLoaded) {
        contentFrame.size.height -= bannerHeight;
		bannerOrigin.y -= bannerHeight;
        tableFrame.size.height = fullViewHeight - bannerHeight;
    } else {
		bannerOrigin.y += bannerHeight;
        tableFrame.size.height = fullViewHeight;
    }
    self.tv.frame = tableFrame;
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         contentView.frame = contentFrame;
                         [contentView layoutIfNeeded];
                         banner.frame = CGRectMake(bannerOrigin.x, bannerOrigin.y, banner.frame.size.width, banner.frame.size.height);
                     }];
}


#pragma mark ADBannerViewDelegate methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutForCurrentOrientation:YES];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self layoutForCurrentOrientation:YES];
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
}

@end

