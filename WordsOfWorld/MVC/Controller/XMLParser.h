//
//  XMLParser.h
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWDefinition.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>{
    NSXMLParser *xmlParser;
    NSMutableArray *definitions;
    WWDefinition *definition;
    NSMutableString *currentElement;
}

- (NSArray *)parseDefinitions:(NSString *)string;

@end
