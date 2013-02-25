//
//  HomeworkAssignmentTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 10/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Homework;


@interface HomeworkAssignmentTableViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	IBOutlet UIPickerView *pickerView;
	Homework *homework;
	NSArray *assignments;
}

@property(nonatomic,retain)Homework *homework;
@property(nonatomic,retain)NSArray *assignments;

@end
