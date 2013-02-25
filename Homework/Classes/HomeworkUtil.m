//
//  HomeworkUtil.m
//  Homework
//
//  Created by Jon Pedersen on 09/04/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import "HomeworkUtil.h"
#import "Homework.h"


@implementation HomeworkUtil

+ (UIColor *)getColor:(NSDate *)dueDate {
	if (!dueDate) {
		return [UIColor grayColor];
	}
	long now = [[NSDate date] timeIntervalSince1970];
	long due = [dueDate timeIntervalSince1970];
	long to = due - now;
	long oneWeek = 7 * 24 * 60 * 60;
	if (to < 0) {
		return [UIColor redColor];
	} else if (to < oneWeek) {
		return [UIColor orangeColor];
	} else if (to < (oneWeek * 2)) {
		return [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
	} else {
		return [UIColor blackColor];
//		return [UIColor grayColor];
	}
}

+ (NSDate *)getNextDue:(NSSet *)homeworks {
	NSDate *currDate = nil;
	for (Homework *homework in homeworks) {
		if (!homework.delivered) {
			if (!currDate) {
				currDate = homework.due;
			} else {
				currDate = [currDate earlierDate:homework.due];
			}
		}
	}
	return currDate;
}

@end
