//
//  FileStore.h
//  testBison
//
//  Created by 4205fy on 13-3-27.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ElementStore;

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
    int first_line;
    int first_column;
    int last_line;
    int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif

typedef enum StoreElementType {
    ELEMENT_TYPE_METHOD = 0,
    ELEMENT_TYPE_FUNCTION,
    ELEMENT_TYPE_CLASS
}ElementType;

@interface FileStore : NSObject
@property (nonatomic,retain) NSString *filePath;
@property (nonatomic,retain) NSMutableArray *allElements;
@property (nonatomic,retain) NSMutableArray *allRecords;

-(NSString*)fileName;
-(NSArray*)searchForString:(NSString*)keyword;
-(void)addElement:(ElementStore*)element;
-(void)clearAll;
@end




@interface ElementStore:NSObject

-(NSArray*)keywords;

@property (nonatomic,retain) NSString *belongTofile;

@property (nonatomic,retain) NSString *name;

@property (nonatomic,assign) ElementType type;

@property (nonatomic,assign) YYLTYPE location;

@end