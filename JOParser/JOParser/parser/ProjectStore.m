//
//  ProjectStore.m
//  testBison
//
//  Created by 4205fy on 13-3-27.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//

#import "ProjectStore.h"
#import "FileStore.h"




static ProjectStore *sharedStore=nil;

@implementation ProjectStore
@synthesize fileStores,currentFileStore;

+(ProjectStore*)sharedStore
{
    if(sharedStore == nil){
        sharedStore = [[ProjectStore alloc]init];
    }
    return sharedStore;
}


-(id)init
{
    self = [super init];
    fileStores = [[NSMutableDictionary alloc]init];
    
    return self;
}

-(FileStore*)fileStoreOfPath:(NSString*)path
{
    FileStore *fs = [fileStores valueForKey:path];
    if (fs ==nil) {
        fs= [[FileStore alloc]init];
        fs.filePath = path;
        [fileStores setValue:fs forKey:path];
        [fs release];
    }
    return fs;
}



-(NSArray*)searchForString:(NSString*)keyword inFilePath:(NSString*)filePath
{
    if(keyword==nil || keyword.length==0)return nil;
    
    FileStore *fileStore = [self fileStoreOfPath:filePath];
    if(fileStore==nil)return nil;
    
    return [fileStore searchForString:keyword];
}

-(NSArray*)searchForString:(NSString*)keyword exceptFilePath:(NSString*)filePath
{
    if(keyword==nil || keyword.length==0)return nil;
    NSMutableArray *resultArray = [NSMutableArray array];
    for (FileStore *fileStore in fileStores.allValues){
        if([fileStore.filePath isEqualToString:filePath])
            continue;
        NSArray *result = [fileStore searchForString:keyword];
        
        if(result==nil)continue;
        
        [resultArray addObjectsFromArray:result];
        
    }
    if(resultArray.count==0)return nil;
    
    return  resultArray;
}


-(void)storeClassInterface:(NSString*)name location:(YYLTYPE)loc
{
    ElementStore *element = [[ElementStore alloc]init];
    element.name = name;
    element.name = [@"@interface " stringByAppendingString:element.name];
    element.location = loc;
    element.type = ELEMENT_TYPE_CLASS;
    
    FileStore *currentFile = currentFileStore;
    [currentFile addElement:element];
    [element release];
    
    NSLog(@"class int:%@",element.name);
}

-(void)storeClassImp:(NSString*)name location:(YYLTYPE)loc
{
    ElementStore *element = [[ElementStore alloc]init];
    element.name = name;
    element.name = [@"@imp " stringByAppendingString:element.name];
    element.location = loc;
    element.type = ELEMENT_TYPE_CLASS;
    
    FileStore *currentFile = currentFileStore;
    [currentFile addElement:element];
    [element release];
    
    NSLog(@"class imp:%@",element.name);
}


-(void)storeClassMethod:(NSDictionary*)methodDic location:(YYLTYPE)loc
{
    ElementStore *element = [[ElementStore alloc]init];
    element.name = [self methodNameFromDic:methodDic];
    element.name = [@"+" stringByAppendingString:element.name];
    element.location = loc;
    element.type = ELEMENT_TYPE_METHOD;
    
    FileStore *currentFile = currentFileStore;
    [currentFile addElement:element];
    [element release];
    
//    NSLog(@"classmethodName:%@",element.name);

}

-(void)storeInstanceMethod:(NSDictionary*)methodDic location:(YYLTYPE)loc
{
    ElementStore *element = [[ElementStore alloc]init];
    element.name = [self methodNameFromDic:methodDic];
    element.name = [@"-" stringByAppendingString:element.name];
    element.location = loc;
    element.type = ELEMENT_TYPE_METHOD;
    
    FileStore *currentFile = currentFileStore;
    [currentFile addElement:element];
    [element release];
    
//    NSLog(@"instanceMethodName:%@",element.name);
}

-(NSString*)methodNameFromDic:(NSDictionary*)methodDic
{
//    NSLog(@"methodDic:%@",methodDic);
    NSString *methodName = @"";
    id keywordDecarator = [methodDic valueForKeyPath:@"keyword_selector.keyword_declarator"];
    
    if(keywordDecarator){
        if([keywordDecarator isKindOfClass:[NSArray class]]){
            NSArray *keywordDecaratorArray = keywordDecarator;
            for(NSDictionary *selectorDic in keywordDecaratorArray){
                NSString *selector = [selectorDic valueForKeyPath:@"selector.IDENTIFIER"];
                if(selector)
                    methodName = [methodName stringByAppendingFormat:@"%@:",selector];
            }
        }else if([keywordDecarator isKindOfClass:[NSDictionary class]]){
            NSString *selector = [keywordDecarator valueForKeyPath:@"selector.IDENTIFIER"];
            if(selector)
                methodName = [methodName stringByAppendingFormat:@"%@:",selector];
        }
        
    }else{
    
        NSDictionary *unaryDecarator = [methodDic objectForKey:@"unary_selector"];
        if(unaryDecarator){
            NSString *selector = [unaryDecarator valueForKeyPath:@"selector.IDENTIFIER"];
            if(selector)
                methodName = [methodName stringByAppendingFormat:@"%@",selector];
        }
        
    }
    return methodName;
}



-(void)reset
{
}
@end
