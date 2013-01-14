//
//  QuizViewController.m
//  Quiz
//
//  Created by Ryan Blunden on 01/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  // CAl the init method implemented by the superclass
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Create two arrays filled questions and answers
    questions = [[NSArray alloc] initWithObjects:
        @"From what is cognac made?",
        @"What is 7 + 7",
        @"What is the capital of Vermont?", nil];

    answers = [[NSArray alloc] initWithObjects:@"Grapes", @"14", @"Montpelier", nil];
  }

  return self;
}

- (IBAction)showQuestion:(id)sender {
  // Step to the next question
  currentQuestionIndex += 1;

  // Am I paste the last question index?
  if (currentQuestionIndex == [questions count]) {
    currentQuestionIndex = 0;
  }

  // Get the string at that index in the questions array
  NSString *question = [questions objectAtIndex:currentQuestionIndex];
  [questionField setText:question];
  [answerField setText:@"???"];
}

- (IBAction)showAnswer:(id)sender {
  NSString *answer = [answers objectAtIndex:currentQuestionIndex];
  [answerField setText:answer];
}

@end