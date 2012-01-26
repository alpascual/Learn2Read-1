//
//  LearningViewController.m
//  LearnRead
//
//  Created by Albert Pascual on 10/7/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "LearningViewController.h"

@implementation LearningViewController

@synthesize internetSound,sound, words;
@synthesize firstLetter, secondLetter, thirdLetter;
@synthesize highlightTimer;
@synthesize labelPoints, labelInfo;
@synthesize questionImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.questionImage.hidden = YES;
    
    NSArray *customColor = [NSArray arrayWithObjects:(id)
                            [UIColor redColor].CGColor,
                            [UIColor redColor].CGColor, nil];
    
    againButton = [[PSStoreButton storeButton] retain];
    againButton.buttonDelegate = self;
    againButton.buttonData = [PSStoreButtonData dataWithLabel:@"Again" colors:[PSStoreButton appStoreGreenColor] enabled:YES];
    againButton.tag = 1; // mark button for delegate
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        againButton.frame = CGRectMake(25, 290, 100, 40);
    else
        againButton.frame = CGRectMake(225, 490, 100, 40);
    [self.view addSubview:againButton];
    
    nextButton = [[PSStoreButton storeButton] retain];
    nextButton.buttonDelegate = self;
    nextButton.buttonData = [PSStoreButtonData dataWithLabel:@"Stop" colors:customColor enabled:YES];
    nextButton.tag = 2; // mark button for delegate
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        nextButton.frame = CGRectMake(200, 290, 100, 40);
    else
        nextButton.frame = CGRectMake(400, 490, 100, 40);
    [self.view addSubview:nextButton];
    
    helpButton = [[PSStoreButton storeButton] retain];
    helpButton.buttonDelegate = self;
    helpButton.buttonData = [PSStoreButtonData dataWithLabel:@"Help" colors:[PSStoreButton appStoreBlueColor] enabled:YES];
    helpButton.tag = 3; // mark button for delegate
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
         helpButton.frame = CGRectMake(110, 350, 100, 40);
    else
        helpButton.frame = CGRectMake(310, 550, 100, 40);
    [self.view addSubview:helpButton];
    
    
    // Start the voice of introduction and instructions
    
    // Start the timer that will help in how long as well as when to jump into the game
    // to make sure the child is learning as well is paying attention
    // then keep a buffer or 3 words and ask the child to click at the word!! 
    // move the buttons if you can to make it more difficult and fun
    
    self.internetSound = [[PlayInternetSound alloc] init];
    self.words = [[wordList alloc] init];
    self.sound = [[SoundManager alloc] init];
    
    countWords = 0;
    countLetters = 0;
    
    // Show the points at start up
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    
    if ( [myPrefs stringForKey:@"score"] != nil )
        self.labelPoints.text = [[NSString alloc] initWithFormat:@"Points %@", [myPrefs stringForKey:@"score"]];
    else
        points = 0;
    
    [self start];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) start
{        
    
    // Get a word
    randomWord = [self.words GetRandomWord];
    
    self.firstLetter.text = [randomWord substringWithRange:NSMakeRange(0, 1)];
    self.secondLetter.text = [randomWord substringWithRange:NSMakeRange(1, 1)];
    self.thirdLetter.text = [randomWord substringWithRange:NSMakeRange(2, 1)];
        
    
    self.highlightTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self selector: @selector(timerCallback:) userInfo: nil repeats: YES];
    
    
}

- (void)timerCallback:(NSTimer *)timer {
	
    countLetters++;
    
    self.firstLetter.highlighted = NO;
    self.secondLetter.highlighted = NO;
    self.thirdLetter.highlighted = NO;
    // Show the hightlights
    if ( countLetters == 1 )
    {
        self.firstLetter.highlighted = YES;
        // Play the letter
        [self.sound addSoundToQueue:self.firstLetter.text];
        [self.sound playQueue];
    }
    else if ( countLetters == 2 )
    {
        self.secondLetter.highlighted = YES;
        //Play the letter
        [self.sound addSoundToQueue:self.secondLetter.text];
        [self.sound playQueue];
    }
    else if ( countLetters == 3 )
    {
        self.thirdLetter.highlighted = YES;
        //Play the letter
        [self.sound addSoundToQueue:self.thirdLetter.text];
        [self.sound playQueue];
    }
    else if (countLetters == 4 )
    {
        //Play the word
        NSString *wordToPlay = [[NSString alloc] initWithFormat:@"http://translate.google.com/translate_tts?q=%@", randomWord];
        
        [self.internetSound playOneSound:wordToPlay]; 
        
        [wordToPlay release];
    }
    
    if ( countLetters == 5 )
    {
        countWords++;
        countLetters = 0;
        [self.highlightTimer invalidate];
        
        // Already 3 words, ask a question
        if ( countWords == 3)
        {
            countWords = 0;
            countLetters = 0;            
            
            randomWord = [self.words GetRandomWord];
            NSString *random1 = [self.words GetRandomWord];
            NSString *random2 = [self.words GetRandomWord];
            NSString *random3 = [self.words GetRandomWord];
            
            int iPos = [self.words GetRandomNumber:3];
            switch (iPos) {
                case 0:
                    random1 = randomWord;
                    correctAnswer = 0;
                    break;
                case 1:
                    random2 = randomWord;
                    correctAnswer = 1;
                    break;
                case 2:
                    random3 = randomWord;
                    correctAnswer = 2;
                    
                default:
                    random1 = randomWord;
                    correctAnswer = 0;
                    break;
            }
            
            // Internet Play word            
            NSString *wordToPlay = [[NSString alloc] initWithFormat:@"http://translate.google.com/translate_tts?q=%@", randomWord];            
            [self.internetSound playOneSound:wordToPlay];             
            [wordToPlay release];            
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"What's the word?"
                                          delegate:self
                                          cancelButtonTitle:nil
                                          destructiveButtonTitle:random1
                                          otherButtonTitles:random2, random3, nil];   
            
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:CGRectMake(300, 850, 200, 500) inView:self.view animated:NO];
                self.questionImage.hidden = NO;
            }
                
            else    
                [actionSheet showFromRect:CGRectMake(0, 300, 200, 500) inView:self.view animated:NO];
            
            [actionSheet release];
        }
        else
            [self start];
    }
    
    

}

// What word did the user clicked?
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button pressed %d and correct answer %d", buttonIndex, correctAnswer);
    self.questionImage.hidden = YES;
    
    if ( buttonIndex == correctAnswer)
    {
        // YES say good and get a point
        [self.sound addSoundToQueue:@"yes"];
        
        NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
        
        points++;            
        self.labelPoints.text = [[[NSString alloc] initWithFormat:@"%d", points ] autorelease];            
        [myPrefs setObject:self.labelPoints.text forKey:@"score"];
        
    }
    
    else
    {
        // NO say try again
        [self.sound addSoundToQueue:@"no"];
    }
    
    [self.sound playQueue];
    [self start];
}

- (void)dealloc
{
    [super dealloc];
    
    [self.internetSound release];
    [self.words release];   
    [self.sound release]; 
    [self.highlightTimer release];
}

// PSStoreButtonDelegate
- (void)storeButtonFired:(PSStoreButton *)button {
    /*if(button.tag == 1 || button.tag == 2) {
        if ([button.buttonData.label hasSuffix:@"$"]) {
            [button setButtonData:[PSStoreButtonData dataWithLabel:@"BUY NOW" colors:[PSStoreButton appStoreGreenColor] enabled:YES] animated:YES];
        }else if ([button.buttonData.label isEqualToString:@"BUY NOW"]) {
            [button setButtonData:[PSStoreButtonData dataWithLabel:@"INSTALLING" colors:[PSStoreButton appStoreGrayColor] enabled:NO] animated:YES];
            [self performSelector:@selector(resetButton1) withObject:nil afterDelay:2.0];
        }
    }else if (button.tag == 3) {
        if ([button.buttonData.label hasSuffix:@"Custom"]) {
            [button setButtonData:[PSStoreButtonData dataWithLabel:@"Max Width can be defined" colors:[PSStoreButton appStoreGreenColor] enabled:YES] animated:YES];
        }else {
            [button setButtonData:[PSStoreButtonData dataWithLabel:@"Custom" colors:[PSStoreButton appStoreGrayColor] enabled:YES] animated:YES];
        }
    }*/
    
    [self.highlightTimer invalidate];    
    
    //Again
    if ( button.tag == 1 )
    {
        //Play the word
        // Internet Play word            
        NSString *wordToPlay = [[NSString alloc] initWithFormat:@"http://translate.google.com/translate_tts?q=%@", randomWord];            
        [self.internetSound playOneSound:wordToPlay];             
        [wordToPlay release]; 
    }
    //Next
    else if ( button.tag == 2 )
    {
        /*[self.sound addSoundToQueue:@"stop"];
        [self.sound playQueue]; */       
        
        // TODO, check how to call a delegate here
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Learning Stopped" message:@"You can exit and come back at anytime" delegate:self cancelButtonTitle:@"Resume" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
        
        return;*/
        
        [self.sound addSoundToQueue:@"exit"];
        [self.sound playQueue];
        
    }
    //Help
    else
    {
        //Play the word
        [self.sound addSoundToQueue:@"help1"];
        //[self.sound addSoundToQueue:@"help2"];
        //[self.sound addSoundToQueue:@"help3"];
        //[self.sound addSoundToQueue:@"help4"];
        [self.sound playQueue];
    }
        
    
    
    lastTitle = button.buttonData.label;
    lastColor = [[NSArray alloc] initWithArray:button.buttonData.colors];
    lastFrame = button.frame;
    
    [button setButtonData:[PSStoreButtonData dataWithLabel:@"Please Wait..." colors:[PSStoreButton appStoreGrayColor] enabled:YES] animated:YES];
    
    [self performSelector:@selector(resetButtons:) withObject:button afterDelay:2.0];
}

- (void)resetButtons:(id)sender {
    
    PSStoreButton *button = (PSStoreButton *)sender;
    [button setButtonData:[PSStoreButtonData dataWithLabel:lastTitle colors:lastColor enabled:YES] animated:YES];
    
    button.frame = lastFrame;    
    
    [lastColor release];
    
    self.highlightTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self selector: @selector(timerCallback:) userInfo: nil repeats: YES];
    
}

@end
