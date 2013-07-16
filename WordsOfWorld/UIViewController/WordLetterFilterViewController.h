//
//  WordLetterFilterViewController.h
//  WordsOfWorld
//
//  Created by Brian Quan on 16/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LetterFilter <NSObject>

@required
- (void)getLetterFilter:(NSString *)string;
@end

@interface WordLetterFilterViewController : UIViewController

@property (weak, nonatomic) id <LetterFilter> delegate;

@end
