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
	
}

- (void) BuildWords;
- (NSString*) GetRandomWord;
@end
