//
//  HomeworkUtil.h
//  Homework
//
//  Created by Jon Pedersen on 09/04/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeworkUtil : NSObject {
    
}

+ (UIColor *)getColor:(NSDate *)dueDate;
+ (NSDate *)getNextDue:(NSSet *)homeworks;

@end
