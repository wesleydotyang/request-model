//
//  ParseResult.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "ParseResult.h"

static NSArray *parseResult;
static NSMutableString *errorLog = nil;
static NSMutableString *infoLog = nil;


@implementation ParseResult


+(NSArray *)currentParseResult
{
    return parseResult;
}

+(void)setCurrentParseResult:(NSArray*)result
{
    [parseResult release];
    parseResult = [result retain];
}


+(void)clearLog
{
    if (errorLog) {
        [errorLog setString:@""];
    }
    if (infoLog) {
        [infoLog setString:@""];
    }
}

+(NSString *)errorLog
{
    return errorLog;
}

+(NSString *)infoLog
{
    return infoLog;
}

+(void)appendErrorLog:(NSString *)info
{
    if (errorLog == nil) {
        errorLog = [[NSMutableString alloc] init];
    }
    [errorLog appendFormat:@"\n%@",info ];
}


+(void)appendInfoLog:(NSString *)info
{
    if (infoLog == nil) {
        infoLog = [[NSMutableString alloc] init];
    }
    [infoLog appendFormat:@"\n%@",info ];
}

@end
