//
//  WWDictionaryWS.m
//  WordsOfWorld
//
//  Created by Brian Quan on 16/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WWDictionaryWS.h"
#import "XMLParser.h"

@implementation WWDictionaryWS

- (void)initWithWord:(NSString *)word{
    dataWebService = [NSMutableData data];
    NSString *yourPostString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><Define xmlns=\"http://services.aonaware.com/webservices/\"><word>%@</word></Define></soap12:Body></soap12:Envelope>", word];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://services.aonaware.com/DictService/DictService.asmx"]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"services.aonaware.com" forHTTPHeaderField:@"Host"];
    [request addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%d", [yourPostString length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:[yourPostString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    [myConnection start];
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
    [self.delegate getDefinitions:[parser parseDefinitions:responseString]];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Eror during connection: %@", [error description]);
}

@end
