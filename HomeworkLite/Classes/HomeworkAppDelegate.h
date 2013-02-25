//
//  HomeworkAppDelegate.h
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class RootViewController;

#define DEFAULT_DATA_GENERATED_PREF_KEY @"defaultDataGenerated"
#define DEFAULT_DATA_GENERATED_PREF_DEF @"NO"

@interface HomeworkAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *subjectNavigationController;
    UINavigationController *homeworkNavigationController;
    UINavigationController *assignmentNavigationController;
    UITabBarController *tabBarController;
	NSMutableDictionary *prefs; 
	NSString *prefsFilePath; 
    BOOL defaultDataGenerated;

@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *subjectNavigationController;
@property (nonatomic, retain) IBOutlet UINavigationController *homeworkNavigationController;
@property (nonatomic, retain) IBOutlet UINavigationController *assignmentNavigationController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
//- (void)deleteInContext:(NSManagedObject *)managedObject;
- (RootViewController *)rootViewController;
- (void)createDefaultData;
- (NSArray *)fetchSubjects;
- (NSArray *)fetchAssignments;
- (void)loadPrefs;

@end

