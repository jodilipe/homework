//
//  HomeworkSubjectTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 09/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Homework;


@interface HomeworkSubjectTableViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	IBOutlet UIPickerView *pickerView;
	Homework *homework;
	NSArray *subjects;
}

@property(nonatomic,retain)Homework *homework;
@property(nonatomic,retain)NSArray *subjects;

@end
