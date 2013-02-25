//
//  SubjectTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Subject;

@interface SubjectTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)pushEditViewController:(Subject *) subject withTitle:(NSString *)title;
- (Subject *)createNewSubject;
- (void)editNewSubject;
- (void)saveContext;
- (void)delete:(NSManagedObject*) managedObject;

@end
