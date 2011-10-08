//
//  LearningViewController.h
//  LearnRead
//
//  Created by Albert Pascual on 10/7/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundManager.h"
#import "PlayInternetSound.h"
#import "wordList.h"
#import "PSStoreButton.h"

@interface LearningViewController : UIViewController <PSStoreButtonDelegate,UIActionSheetDelegate>
{
    PlayInternetSound *internetSound;
    SoundManager *sound;
    wordList *words;
    PSStoreButton *againButton;
    PSStoreButton *nextButton;
    PSStoreButton *helpButton;
    
    NSString *lastTitle;
    NSArray *lastColor;
    CGRect lastFrame;
    int countWords;
}

@property (nonatomic, retain) PlayInternetSound *internetSound;
@property (nonatomic, retain) SoundManager *sound;
@property (nonatomic, retain) wordList *words;

- (void) start;

@end
