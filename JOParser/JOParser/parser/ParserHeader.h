//
//  ParserHeader.h
//  BParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#ifndef Bison_ObjectiveCHeader_h
#define Bison_ObjectiveCHeader_h

#import <Foundation/NSData.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#import "NSMutableDictionary+duplicate.h"
#import "NSMutableArray+allownil.h"
#import "Recorder.h"
#import "ProjectStore.h"
#import "ParseResult.h"

#import "JOHeader.h"

#define DEBUG_BISON

#define TOSTR(cstring) [NSString stringWithUTF8String:cstring]


BOOL ParsePreProcessedC(const char *someData);


#endif
