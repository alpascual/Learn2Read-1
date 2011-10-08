//
//  LearnReadAppDelegate.h
//  LearnRead
//
//  Created by Albert Pascual on 10/7/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundManager.h"
#import "LearningViewController.h"

@interface LearnReadAppDelegate : NSObject <UIApplicationDelegate>
{
    SoundManager *sound;
    LearningViewController *learningController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SoundManager *sound;
@property (nonatomic, retain) LearningViewController *learningController;

- (IBAction)StartLearning:(id)sender;

@end
