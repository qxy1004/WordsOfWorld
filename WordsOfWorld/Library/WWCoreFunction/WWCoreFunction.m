//
//  WWCoreFunction.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WWCoreFunction.h"

@implementation WWCoreFunction

+ (NSArray *)loadWords{
    NSString * fName = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"txt"];
    if (fName) {
        NSError *error;
        NSString* fileContents = [NSString stringWithContentsOfFile:fName encoding:NSASCIIStringEncoding error:&error];
        NSArray* allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        NSMutableArray *newArray = [[NSMutableArray alloc] init];
        for (NSString *string in allLinedStrings) {
            if (![string isEqualToString:@""]) {
                [newArray addObject:string];
            }
        }
        return newArray;
    }
    return nil;
}

@end
