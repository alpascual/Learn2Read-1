//
//  wordList.h
//  SpellingBee
//
//  Created by Albert Pascual on 4/11/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface wordList : NSObject {
    
    NSMutableArray *listOfWords;
	int _lastran;
    
    NSMutableArray *_last5;
	
}

@property (nonatomic,retain) NSMutableArray *_last5;

- (void) BuildWords;
- (NSString*) GetRandomWord;
- (int) GetRandomNumber:(int)max;

@end
