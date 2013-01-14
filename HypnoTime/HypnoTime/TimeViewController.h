//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface TimeViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

- (IBAction)showCurrentTime:(id)sender;

@end