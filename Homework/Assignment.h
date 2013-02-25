//
//  Assignment.h
//  Homework
//
//  Created by Jon Pedersen on 11/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Homework;

@interface Assignment :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* homeworks;

@end


@interface Assignment (CoreDataGeneratedAccessors)
- (void)addHomeworksObject:(Homework *)value;
- (void)removeHomeworksObject:(Homework *)value;
- (void)addHomeworks:(NSSet *)value;
- (void)removeHomeworks:(NSSet *)value;

@end

