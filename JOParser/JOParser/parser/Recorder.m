//
//  Recorder.m
//  testBison
//
//  Created by 4205fy on 13-3-24.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//

#import "Recorder.h"


@interface Recorder (){
}

@end

@implementation Recorder
@synthesize allRecords;
static Recorder *sharedInstance=nil;

+(Recorder *)sharedRecorder
{
    if(sharedInstance==nil){
        sharedInstance = [[Recorder alloc]init];
    }
    return sharedInstance;
}


-(id)init
{

    self = [super init];
    allRecords = [[NSMutableArray alloc]init];
    return self;
}
-(void)reset
{
    [self.allRecords removeAllObjects];
}

//-(void)recordType:(RecordType)type value:(const char*)value sline:(int)startLine sCol:(int)startColumn eLine:(int)endLine eCol:(int)endColum
//{
//    
////    NSLog(@"RECORD:%s,%d,[%d,%d %d,%d]",value,type,startLine,startColumn,endLine,endColum);
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
//                       [NSNumber numberWithInt:type],@"type",
//                       [NSString stringWithUTF8String:value],@"value",
//                       [NSNumber numberWithInt:startLine],@"startLine",
//                       [NSNumber numberWithInt:endLine],@"endLine",
//                       [NSNumber numberWithInt:startColumn],@"startColumn",
//                       [NSNumber numberWithInt:endColum],@"endColumn",nil];
//    [allRecords addObject:dic];
//}
-(void)recordType:(RecordType)type value:(NSString*)value sline:(int)startLine sCol:(int)startColumn eLine:(int)endLine eCol:(int)endColum
{
    @synchronized(self){
    NSString *typeStrs[] = {@"COM",@"PRE",@"CLS",@"FUN",@"TYP",@"VAR",@"CLSP",@"FUNP",@"TYPP",@"VARP",@"STR",@"NUM",@"KEY"};
    
    NSLog(@"RECORD:%@,%@,[%d,%d %d,%d]",value,typeStrs[type],startLine,startColumn,endLine,endColum);
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       [NSNumber numberWithInt:type],@"type",
                       value,@"value",
                       [NSNumber numberWithInt:startLine],@"startLine",
                       [NSNumber numberWithInt:endLine],@"endLine",
                       [NSNumber numberWithInt:startColumn],@"startColumn",
                       [NSNumber numberWithInt:endColum],@"endColumn",nil];
    
    [self.allRecords addObject:dic];
    }
}
@end
