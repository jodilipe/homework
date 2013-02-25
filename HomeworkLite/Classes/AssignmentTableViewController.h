//
//  AssignmentTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <iAd/iAd.h>
@class Assignment;

@interface AssignmentTableViewController : UIViewController <NSFetchedResultsControllerDelegate, ADBannerViewDelegate> {

    UIView *contentView;
    ADBannerView *banner;
    IBOutlet UITableView *tv;
	
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet ADBannerView *banner;
@property (nonatomic, retain) UITableView *tv;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)pushEditViewController:(Assignment *) assignment withTitle:(NSString *)title;
- (Assignment *)createNewAssignment;
- (void)editNewAssignment;
- (void)saveContext;
- (void)delete:(NSManagedObject*) managedObject;

@end
