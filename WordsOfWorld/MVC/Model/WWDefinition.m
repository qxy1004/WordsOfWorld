//
//  WWDefinition.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WWDefinition.h"

@implementation WWDefinition

- (NSString *)description{
    return [NSString stringWithFormat:@"Definition of %@ is\r\r %@ from \r\r%@", self.word, self.meaning, self.dictionary];
}

@end
