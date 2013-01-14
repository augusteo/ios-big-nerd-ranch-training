//
//  QuizViewController.h
//  Quiz
//
//  Created by Ryan Blunden on 01/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController {
  unsigned int currentQuestionIndex;
  
  // Models
  NSArray *questions;
  NSArray *answers;
  
  // View objects
  IBOutlet UILabel *questionField;
  IBOutlet UILabel *answerField;
}

- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end