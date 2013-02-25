//
//  Homework.h
//  Homework
//
//  Created by Jon Pedersen on 11/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Assignment;
@class Subject;

@interface Homework :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * due;
@property (nonatomic, retain) NSDate * delivered;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Assignment * assignment;
@property (nonatomic, retain) Subject * subject;

@end



