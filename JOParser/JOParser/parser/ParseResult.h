//
//  ParseResult.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JOService.h"

@interface ParseResult : NSObject

+(NSArray*)currentParseResult;
+(void)setCurrentParseResult:(NSArray*)result;

+(void)appendInfoLog:(NSString*)info;
+(void)appendErrorLog:(NSString*)info;

+(void)clearLog;

+(NSString*)errorLog;
+(NSString*)infoLog;

@end
