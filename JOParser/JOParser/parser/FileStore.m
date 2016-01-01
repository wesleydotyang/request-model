//
//  FileStore.m
//  testBison
//
//  Created by 4205fy on 13-3-27.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//  

#import "FileStore.h"

@implementation FileStore
@synthesize filePath,allElements,allRecords;

-(id)init
{
    self = [super init];
    allElements = [[NSMutableArray alloc]init];
    allRecords = [[NSMutableArray alloc]init];
    return self;
}

-(NSString*)fileName
{
    return [filePath lastPathComponent];
}

-(void)addElement:(ElementStore*)element
{
    element.belongTofile = filePath;
    [allElements addObject:element];
    
}

-(NSMutableArray *)allElements
{
    [allElements sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        ElementStore *store1 = obj1;
        ElementStore *store2 = obj2;
        return store1.location.first_line-store2.location.first_line;
    }];
    return allElements;
}
-(void)clearAll
{
    [allElements removeAllObjects];
    [allRecords removeAllObjects];
}


-(NSArray*)searchForString:(NSString*)keyword
{
    if(keyword==nil || keyword.length==0)return nil;
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (ElementStore *element in self.allElements) {
        NSArray *keywords = [element keywords];
        for(NSString *key in keywords){
            if([keyword isEqualToString:key]){
                [resultArray addObject:element];
                break;
            }
        }
    }
    
    if(resultArray.count ==0)return nil;
    return resultArray;
}

-(void)dealloc
{
    self.allRecords = nil;
    self.allElements = nil;
    self.filePath = nil;
    [super dealloc];
}

@end



@implementation ElementStore
@synthesize name,type,location,belongTofile;

-(NSArray*)keywords
{
    return  [name componentsSeparatedByCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Element:[%@]%d[%d,%d,%d,%d]",name,type,location.first_line,location.first_column,location.last_line,location.last_column];
}

-(void)dealloc
{
    self.name = nil;
    self.type = nil;
    self.belongTofile = nil;
    [super dealloc];
}

@end