//
//  RootViewController.h
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Homework;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)pushEditViewController:(Homework *)homework withTitle:(NSString *)title;
- (Homework *)createNewHomework;
- (void)editNewHomework;
- (void)saveContext;
- (void)delete:(NSManagedObject*) managedObject;

@end
