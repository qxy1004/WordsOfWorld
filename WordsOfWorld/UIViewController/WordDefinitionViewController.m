//
//  WordDefinitionViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordDefinitionViewController.h"
#import "XMLParser.h"
#import "BQDefine.h"
#import "DALinedTextView.h"
#import "UITabBarController+ShowHideBar.h"

@interface WordDefinitionViewController () <NSURLConnectionDelegate>{
    NSMutableData *dataWebService;
    NSArray *arrayOfResult;
    
    UITextView *mainTextView;
}

@end

@implementation WordDefinitionViewController

#pragma mark - System functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController setHidden:YES];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.string;
    self.view.backgroundColor = [UIColor whiteColor];
    
    dataWebService = [NSMutableData data];
    NSString *yourPostString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><Define xmlns=\"http://services.aonaware.com/webservices/\"><word>%@</word></Define></soap12:Body></soap12:Envelope>", self.string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://services.aonaware.com/DictService/DictService.asmx"]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"services.aonaware.com" forHTTPHeaderField:@"Host"];
    [request addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%d", [yourPostString length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:[yourPostString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    [myConnection start];
    
    mainTextView = [[DALinedTextView alloc] initWithFrame:self.view.bounds];
    mainTextView.editable = NO;
    mainTextView.allowsEditingTextAttributes = YES;
    mainTextView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:mainTextView];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
#ifdef DEBUG
	NSLog(@"dealloc %@", self);
#endif
}

#pragma mark - Self functions
- (void)addTextToTextView{
    NSMutableString *string = [NSMutableString new];
    
    for (WWDefinition *definition in arrayOfResult) {
        [string appendString:definition.dictionary];
        [string appendString:@"\n\n"];
        [string appendString:[self stripDoubleSpaceFrom:[definition.meaning stringByReplacingOccurrencesOfString:@"\n" withString:@""]]];
        [string appendString:@"\n\n"];
    }
    
    mainTextView.text = string;
    
    NSLog(@"%@", string);
}
- (NSString *)stripDoubleSpaceFrom:(NSString *)str {
    while ([str rangeOfString:@"  "].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    return str;
}

#pragma mark - NSURLConnecteion deledate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [dataWebService setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [dataWebService appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *responseString = [[NSString alloc] initWithData:dataWebService encoding:NSUTF8StringEncoding];
    
    XMLParser *parser = [XMLParser new];
    arrayOfResult = [parser parseDefinitions:responseString];
    
    [self addTextToTextView];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Eror during connection: %@", [error description]);
}
@end
