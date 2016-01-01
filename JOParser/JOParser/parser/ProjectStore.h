//
//  ProjectStore.h
//  testBison
//
//  Created by 4205fy on 13-3-27.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//
//  !!! set currentFileStore and begin parsing. parse result will store in this class

#import <Foundation/Foundation.h>
#import "FileStore.h"



@interface ProjectStore : NSObject


@property (nonatomic,retain)     NSMutableDictionary *fileStores;
@property (nonatomic,retain)     FileStore           *currentFileStore;

+(ProjectStore*)sharedStore;

-(NSArray*)searchForString:(NSString*)keyword inFilePath:(NSString*)filePath;
-(NSArray*)searchForString:(NSString*)keyword exceptFilePath:(NSString*)filePath;


-(FileStore*)fileStoreOfPath:(NSString*)path;

-(void)storeInstanceMethod:(NSDictionary*)methodDic location:(YYLTYPE)loc;
-(void)storeClassMethod:(NSDictionary*)methodDic location:(YYLTYPE)loc;
-(void)storeClassInterface:(NSString*)name location:(YYLTYPE)loc;
-(void)storeClassImp:(NSString*)name location:(YYLTYPE)loc;


@end
