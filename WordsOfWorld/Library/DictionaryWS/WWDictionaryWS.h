//
//  WWDictionaryWS.h
//  WordsOfWorld
//
//  Created by Brian Quan on 16/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WWDictionaryWS <NSObject>
@required
- (void)getDefinitions:(NSArray *)definitions;
@end

@interface WWDictionaryWS : NSObject <NSURLConnectionDelegate>{
    NSMutableData *dataWebService;
}

@property (weak, nonatomic) id <WWDictionaryWS> delegate;

- (void)initWithWord:(NSString *)word;

@end
