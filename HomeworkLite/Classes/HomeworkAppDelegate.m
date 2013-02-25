//
//  HomeworkAppDelegate.m
//  Homework
//
//  Created by Jon Pedersen on 06/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "HomeworkAppDelegate.h"
#import "RootViewController.h"
#import "SubjectTableViewController.h"
#import "AssignmentTableViewController.h"
#import "Homework.h"
#import "Subject.h"
#import "Assignment.h"


@implementation HomeworkAppDelegate

@synthesize window;
@synthesize subjectNavigationController;
@synthesize homeworkNavigationController;
@synthesize assignmentNavigationController;
@synthesize tabBarController;


- (RootViewController *)rootViewController {
	return (RootViewController *)[homeworkNavigationController topViewController];
}

- (NSArray *)fetch:(NSString *)entityName {
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
	[request setEntity:entity];
	NSError *error = nil;
	NSArray *entities = [[self managedObjectContext] executeFetchRequest:request error:&error];
    NSSortDescriptor *nameSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]  autorelease];
	NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:nameSortDescriptor, nil] autorelease];
	return [entities sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSArray *)fetchSubjects {
	return [self fetch:@"Subject"];
}
	
- (NSArray *)fetchAssignments {
	return [self fetch:@"Assignment"];
}		

#pragma mark -
#pragma mark Application lifecycle

- (void)awakeFromNib {    
    
    RootViewController *rootViewController = (RootViewController *)[homeworkNavigationController topViewController];
    rootViewController.managedObjectContext = self.managedObjectContext;
    
    SubjectTableViewController *subjectTableViewController = (SubjectTableViewController *)[subjectNavigationController topViewController];
    subjectTableViewController.managedObjectContext = self.managedObjectContext;
    
    AssignmentTableViewController *assignmentTableViewController = (AssignmentTableViewController *)[assignmentNavigationController topViewController];
    assignmentTableViewController.managedObjectContext = self.managedObjectContext;
	
    [self loadPrefs];
	[self createDefaultData];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Add the navigation controller's view to the window and display.
	[self.window addSubview:tabBarController.view];
    //    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark -
#pragma mark Prefs stuff

- (void) initPrefsFilePath { 
	NSString *documentsDirectory = 
	[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]; 
	prefsFilePath = [documentsDirectory stringByAppendingPathComponent:@"flippingprefs.plist"]; 
	[prefsFilePath retain]; 
} 

- (void) setDefaultPrefs {
    [prefs setObject: DEFAULT_DATA_GENERATED_PREF_DEF forKey: DEFAULT_DATA_GENERATED_PREF_KEY]; 
}

- (void) updatePrefs {
    [prefs setObject:defaultDataGenerated ? @"YES" : @"NO" forKey: DEFAULT_DATA_GENERATED_PREF_KEY]; 
}

- (void) setAttributesFromPrefs {
    defaultDataGenerated = [(NSString*)[prefs objectForKey: DEFAULT_DATA_GENERATED_PREF_KEY] boolValue];
    //	NSString *prefTimeZone = [prefs objectForKey: TIME_ZONE_PREF_KEY];
}

- (void) loadPrefs { 
	if (prefsFilePath == nil) {
		[self initPrefsFilePath]; 
    }
	if ([[NSFileManager defaultManager] fileExistsAtPath: prefsFilePath]) { 
		prefs = [[NSMutableDictionary alloc] initWithContentsOfFile: prefsFilePath]; 
	} else { 
		prefs = [[NSMutableDictionary alloc] initWithCapacity: 2]; 
        [self setDefaultPrefs];
	} 
    [self setAttributesFromPrefs];
} 

- (void) savePrefs {
    [self updatePrefs];
	[prefs writeToFile: prefsFilePath atomically: YES]; 
}

#pragma mark -
#pragma mark Default data

- (Subject *)getOrCreateSubject:(NSString *)name {
    NSArray* subjects = [self fetchSubjects];
    for (Subject *subject in subjects) {
        if ([subject.name isEqualToString:name]) {
            return subject;
        }
    }
	Subject *subject = [NSEntityDescription insertNewObjectForEntityForName:@"Subject" inManagedObjectContext:self.managedObjectContext];
	subject.name = name;
    return subject;
}

- (Assignment *)getOrCreateAssignment:(NSString *)name {
    NSArray* assignments = [self fetchAssignments];
    for (Assignment *assignment in assignments) {
        if ([assignment.name isEqualToString:name]) {
            return assignment;
        }
    }
	Assignment *assignment = [NSEntityDescription insertNewObjectForEntityForName:@"Assignment" inManagedObjectContext:self.managedObjectContext];
	assignment.name = name;
    return assignment;
}

- (void)createDefaultHomework:(NSString *)assignmentName withSubject:(NSString *)subjectName withDueDate:(NSDate *)dueDate withDeliveredDate:(NSDate *)deliveredDate withNote:(NSString *)note {
	RootViewController *rootViewController = (RootViewController *)[homeworkNavigationController topViewController];
	Homework *homework = [rootViewController createNewHomework];
	homework.due = dueDate;
    
    if (deliveredDate) {
        homework.delivered = deliveredDate;
    }
    if (note) {
        homework.note = note;
    }
	
	homework.assignment = [self getOrCreateAssignment:assignmentName];
    
	homework.subject = [self getOrCreateSubject:subjectName];
}

- (void)createDefaultData {
	if (!defaultDataGenerated) {
        long dayInSecs = 24 * 60 * 60;
		NSLocale *locale = [NSLocale currentLocale];
		if ([@"da_DK" isEqualToString:[locale localeIdentifier]]) {
			[self createDefaultHomework:@"Stil" withSubject:@"Dansk" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * -5] withDeliveredDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * -5] withNote:@"Karen Blixens liv."];
			[self createDefaultHomework:@"Stil" withSubject:@"Engelsk" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * -1] withDeliveredDate:nil withNote:@"Minimum 10 sider."];
			[self createDefaultHomework:@"Læsning" withSubject:@"Engelsk" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 3] withDeliveredDate:nil withNote:nil];
			[self createDefaultHomework:@"Blækregning" withSubject:@"Matematik" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 16] withDeliveredDate:nil withNote:nil];
			[self createDefaultHomework:@"Rapport" withSubject:@"Biologi" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 12] withDeliveredDate:nil withNote:nil];
			[self createDefaultHomework:@"Rapport" withSubject:@"Fysik" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 4] withDeliveredDate:nil withNote:nil];
			[self createDefaultHomework:@"Rapport" withSubject:@"Fysik" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 22] withDeliveredDate:nil withNote:@"Konstruer en brødrister"];
			[self saveContext];
		} else {
			[self createDefaultHomework:@"Algebra" withSubject:@"Math" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * -5] withDeliveredDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * -5] withNote:nil];
			[self createDefaultHomework:@"Read" withSubject:@"History" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * -1] withDeliveredDate:nil withNote:nil];
			[self createDefaultHomework:@"Report" withSubject:@"Biology" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 3] withDeliveredDate:nil withNote:@"12 pages minimum."];
			[self createDefaultHomework:@"Read" withSubject:@"English" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 16] withDeliveredDate:nil withNote:@"Pages 105-144."];
			[self createDefaultHomework:@"Essay" withSubject:@"English" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 12] withDeliveredDate:nil withNote:@"Famous Americans: Benjamin Franklin."];
			[self createDefaultHomework:@"Report" withSubject:@"Physics" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 4] withDeliveredDate:nil withNote:nil];
			[self createDefaultHomework:@"Report" withSubject:@"Physics" withDueDate:[NSDate dateWithTimeIntervalSinceNow:dayInSecs * 22] withDeliveredDate:nil withNote:@"Build a toaster."];
			[self saveContext];
		}
        defaultDataGenerated = YES;
        [self savePrefs];
	}
}

#pragma mark -
#pragma mark Core Data stack

- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //            abort();
        } 
    }
}    

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"Homework" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Homework.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [homeworkNavigationController release];
    [subjectNavigationController release];
    [assignmentNavigationController release];
    [window release];
    [super dealloc];
}


@end

