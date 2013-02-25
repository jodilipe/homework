//
//  HomeworkDeliveredTableViewController.h
//  Homework
//
//  Created by Jon Pedersen on 12/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Homework;


@interface HomeworkDeliveredTableViewController : UITableViewController {
	IBOutlet UIDatePicker *datePicker;
	Homework *homework;
}
@property(nonatomic,retain)Homework *homework;

-(IBAction)dateChanged;

@end
