/********************************************************
 *  {{class_name}}.m
 *  {{project_name}}
 *
 *  Created by J2Objc(Json to objc) on {{date}}.
 *  Copyright (c) 2013 WesleyYang. All rights reserved.
 *
 *  THIS FILE IS AUTO-GENERATED BY J2OBJC. DO NOT TRY TO
 *  MODIFY IT UNLESS YOU ARE NOT RELYING ON J2OBJC FOR
 *  MAKING ANY CHANGES!
 *
 ********************************************************/


#import "{{class_name}}.h"
#import "AHDefine.h"
#import "NSDictionary+MultiKeys.h"


@implementation {{class_name}}

+ ({{class_name}}*)objectFromDictionary:(NSDictionary*)dataDic
{
    if (dataDic == nil)
        return nil;
    
    
    {{class_name}} *info = [[{{class_name}} alloc] init];
    
    {{#properties_value}}
    {{#properties_setvalue}}info.{{property_name}} = [dataDic objectForPossibleKeys:@[{{{property_server_names}}}]];{{/properties_setvalue}}{{#properties_setvalue_with_convert}}id {{property_name}}ValueObj =  [dataDic objectForPossibleKeys:@[{{{property_server_names}}}]];
    info.{{property_name}} = [{{property_name}}ValueObj {{property_type_convert_func}}];{{/properties_setvalue_with_convert}}{{#properties_setvalue_obj}}NSDictionary *{{property_name}}Dic = [dataDic objectForPossibleKeys:@[{{{property_server_names}}}]];
    info.{{property_name}} = [{{property_type}} objectFromDictionary:{{property_name}}Dic];{{/properties_setvalue_obj}}{{#properties_setvalue_array}}NSDictionary *{{property_name}}Dic = [dataDic objectForPossibleKeys:@[{{{property_server_names}}}]];
    info.{{property_name}} = [{{property_subtype}} arrayFromDictionaryArray:{{property_name}}Dic];{{/properties_setvalue_array}}
    {{/properties_value}}

    return AH_AUTORELEASE(info);
}


+ (NSArray*)arrayFromDictionaryArray:(NSArray*)dataDicArray;
{
    
    if(dataDicArray == nil)
        return nil;
    
    if([dataDicArray isKindOfClass:[NSArray class]] == NO){
        NSLog(@"Error:+arrayFromDictionaryArray: input argument is not NSArray!");
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for(NSDictionary *dic in dataDicArray){
        
        if([dic isKindOfClass:[NSDictionary class]] == NO)
            continue;
        
        id obj = [self objectFromDictionary:dic];
        
        if(obj)
           [resultArray addObject:obj];
        
    }
    
    if(resultArray.count == 0)
        return nil;

    return resultArray;
}


-(void)dealloc
{
{{#properties_dealloc}}
    AH_RELEASE(_{{property_name}});{{/properties_dealloc}}

    AH_SUPER_DEALLOC;
}

@end



