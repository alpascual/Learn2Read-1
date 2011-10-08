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
    
    NSArray *customColor = [NSArray arrayWithObjects:(id)
                            [UIColor redColor].CGColor,
                            [UIColor redColor].CGColor, nil];
    
    againButton = [[PSStoreButton storeButton] retain];
    againButton.buttonDelegate = self;
    againButton.buttonData = [PSStoreButtonData dataWithLabel:@"Again" colors:customColor enabled:YES];
    againButton.tag = 1; // mark button for delegate
    againButton.frame = CGRectMake(25, 290, 100, 40);
    [self.view addSubview:againButton];
    
    nextButton = [[PSStoreButton storeButton] retain];
    nextButton.buttonDelegate = self;
    nextButton.buttonData = [PSStoreButtonData dataWithLabel:@"Next" colors:[PSStoreButton appStoreGreenColor] enabled:YES];
    nextButton.tag = 2; // mark button for delegate
    nextButton.frame = CGRectMake(200, 290, 100, 40);
    [self.view addSubview:nextButton];
    
    helpButton = [[PSStoreButton storeButton] retain];
    helpButton.buttonDelegate = self;
    helpButton.buttonData = [PSStoreButtonData dataWithLabel:@"Help" colors:[PSStoreButton appStoreBlueColor] enabled:YES];
    helpButton.tag = 3; // mark button for delegate
    helpButton.frame = CGRectMake(110, 350, 100, 40);
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
        
    // This will run forever using somebody closes
    while (true) {
        
    
        // Get a word
        /*self.randomWord = [self.words GetRandomWord];
         
         self.lettersLeft.text = [[[NSString alloc] initWithFormat:@"%d", [self.randomWord length]] autorelease];
         */

        // Play each letter of the word
        
        // Say the word
        
        countWords++;
        
        if ( countWords == 3 )
        {
            countWords = 0;
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"What's the word?"
                                          delegate:self
                                          cancelButtonTitle:@"Word 3"
                                          destructiveButtonTitle:@"Word 1"
                                          otherButtonTitles:@"Word 2", nil];
            
            [actionSheet showInView:self.view];
            [actionSheet release];
        }
        
    }
}

// What word did the user clicked?
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

- (void)dealloc
{
    [super dealloc];
    
    [self.internetSound release];
    [self.words release];   
    [self.sound release];  
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
}

@end
