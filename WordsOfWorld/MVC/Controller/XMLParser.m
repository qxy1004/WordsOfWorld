//
//  XMLParser.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

- (NSArray *)parseDefinitions:(NSString *)string{
    
    definitions = [NSMutableArray new];
	NSData* data=[string dataUsingEncoding:NSUTF8StringEncoding];
    
	xmlParser = [[NSXMLParser alloc] initWithData:data];
	
	[xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:NO];
	[xmlParser setShouldReportNamespacePrefixes:NO];
	[xmlParser setShouldResolveExternalEntities:NO];
	[xmlParser parse];
    
    //NSLog(@"definitions %@", definitions);
    
	return definitions;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	NSLog(@"Error Parser:%@",[parseError localizedDescription]);
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"Definition"]) {
        definition = [WWDefinition new];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"Word"]) {
        definition.word = currentElement;
    }
    else if ([elementName isEqualToString:@"Name"]){
        definition.dictionary = currentElement;
    }
    else if ([elementName isEqualToString:@"WordDefinition"]) {
        definition.meaning = currentElement;
        [definitions addObject:definition];
    }
    
    currentElement = nil;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if(!currentElement)
        currentElement = [[NSMutableString alloc] initWithString:string];
    else
        [currentElement appendString:string];
    
}

@end
