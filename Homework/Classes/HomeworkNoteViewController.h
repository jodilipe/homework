//
//  HomeworkNoteViewController.h
//  Homework
//
//  Created by Jon Pedersen on 11/03/11.
//  Copyright 2011 jApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Homework;


@interface HomeworkNoteViewController : UIViewController <UITextViewDelegate> {
	Homework *homework;
	IBOutlet UITextView *textView;
}

@property(nonatomic,retain)Homework *homework;

@end
