//
//  HomeworkDueTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 09/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Homework;


@interface HomeworkDueTableViewController : UITableViewController {
	IBOutlet UIDatePicker *datePicker;
	Homework *homework;
}

@property(nonatomic,retain)Homework *homework;

-(IBAction)dateChanged;

@end
