//
//  testBison
//
//  Created by 4205fy on 13-3-24.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//

#import "PublicParser.h"
#import "ParserHeader.h"


static PublicParser *sharedParser=nil;

@implementation PublicParser

//void  (^completionBlock)();
 NSCondition *lock;


+(PublicParser*)sharedParser
{
    if (sharedParser==nil) {
        sharedParser = [[PublicParser alloc]init];
    }
    return sharedParser;
}

-(id)init
{
    self = [super init];
    lock = [[NSCondition alloc]init];
    return self;
}



-(void)parseObjectiveCString:(NSString *)input completion:(void(^)(NSArray* result,NSString *logInfo,NSString *logError))completionBlock
{
    [[Recorder sharedRecorder] reset];
    
    [ParseResult clearLog];
    [ParseResult setCurrentParseResult:nil];
    
    [self parseString:input];
    completionBlock([ParseResult currentParseResult],[ParseResult infoLog],[ParseResult errorLog]);
}

-(void)parseString:(NSString*)input{
    [lock lock];
    try {
        ParsePreProcessedC([input cStringUsingEncoding:NSUTF8StringEncoding]);

    } catch (NSException *e) {
        //nothing
        NSLog(@"exception occured");
    }
    [lock unlock];
}

-(void)dealloc
{
    [lock release];
    [super dealloc];
}

@end
