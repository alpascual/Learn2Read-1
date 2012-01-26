//
//  RootViewController.h
//  MathTutor
//
//  Created by Albert Pascual on 10/9/11.
//  Copyright (c) 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningViewController.h"

@interface RootViewController : UIViewController
{
    LearningViewController *startController;
    
}

@property (nonatomic, retain) LearningViewController *startController;


- (IBAction) startCalled;

@end
