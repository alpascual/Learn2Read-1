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
    NSString *randomWord;
    
    UILabel *firstLetter;
    UILabel *secondLetter;
    UILabel *thirdLetter;
    
    NSTimer *highlightTimer;
    int countLetters;
    NSInteger correctAnswer;
    
    UILabel *labelPoints;
    UILabel *labelInfo;
    
    NSInteger points;
    
    UIImageView *questionImage;
}

@property (nonatomic, retain) PlayInternetSound *internetSound;
@property (nonatomic, retain) SoundManager *sound;
@property (nonatomic, retain) wordList *words;

@property (nonatomic, retain) IBOutlet UILabel *firstLetter;
@property (nonatomic, retain) IBOutlet UILabel *secondLetter;
@property (nonatomic, retain) IBOutlet UILabel *thirdLetter;

@property (nonatomic, retain) NSTimer *highlightTimer;

@property (nonatomic, retain) IBOutlet UILabel *labelPoints;
@property (nonatomic, retain) IBOutlet UILabel *labelInfo;

@property (nonatomic, retain) IBOutlet UIImageView *questionImage;

- (void) start;

@end
