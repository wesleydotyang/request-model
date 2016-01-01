//
//  Recorder.h
//  testBison
//
//  Created by 4205fy on 13-3-24.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//
//record objects parsed by parser for color text

#import <Foundation/Foundation.h>


#define REC(type,val,a)     [[Recorder sharedRecorder]recordType:type value:val sline:a.first_line sCol:a.first_column eLine:a.last_line eCol:a.last_column]



typedef enum _typename{
    RECTYPE_COMMENT = 0,
    RECTYPE_PRECOMPILER,
    RECTYPE_CLASS,
    RECTYPE_FUNC,
    RECTYPE_TYPE,
    RECTYPE_VAR,
    RECTYPE_CLASS_P,
    RECTYPE_FUNC_P,
    RECTYPE_TYPE_P,
    RECTYPE_VAR_P,
    RECTYPE_STRING,
    RECTYPE_NUMBER,
    RECTYPE_KEYWORD//12
}RecordType;





@interface Recorder : NSObject

+(Recorder*)sharedRecorder;

-(void)recordType:(RecordType)type value:(NSString*)value sline:(int)startLine sCol:(int)startColumn eLine:(int)endLine eCol:(int)endColum;

-(void)reset;

@property (atomic,retain) NSMutableArray *allRecords;

@end
