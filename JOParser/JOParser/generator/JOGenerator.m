//
//  JOGenerator.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOGenerator.h"
#import "JOHeader.h"
#import "JOModel.h"
#import "JOProperty.h"
#import "GRMustache.h"

#define ISEMPTY_STR(str) (str==nil || str.length==0)

@interface JOGenerator()

@property (nonatomic,retain) NSMutableDictionary *nameModelDic;

@end


@implementation JOGenerator


-(id)init
{
    if (self = [super init]) {
        self.nameModelDic = [NSMutableDictionary dictionary];
    }
    return self;
}

+(JOGenerator*)generatorFromInput:(id)input outputPath:(NSString*)path
{
    JOGenerator *gen = [[JOGenerator alloc] init];
    gen.input = input;
    gen.outputPath = path;
    
    return [gen autorelease];
}


-(JOModel*)modelForName:(NSString*)name
{
    if (name==nil || name.length==0) {
        return nil;
    }
    JOModel *model = [_nameModelDic objectForKey:name];
    if (model == nil) {
        model = [[JOModel alloc] init];
        model.project = @"J2Objc";
        model.modelName = name;
        [_nameModelDic setObject:model forKey:name];
        [model release];
    }
    return model;
}

-(void)generateOutput
{
    [self parseInput];
    
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];

    for (JOModel *m in self.nameModelDic.allValues) {
//        NSLog(@"[Model]%@\n",[self objectFromModel:m]);
        
        NSString *modelHeaderTemplatePath = [[NSBundle mainBundle] pathForResource:@"ModelTemplate" ofType:@"h" inDirectory:@"resource"];
        NSString *modelImpTemplatePath = [[NSBundle mainBundle] pathForResource:@"ModelTemplate" ofType:@"m" inDirectory:@"resource"];

        GRMustacheTemplate *headerTemplate = [GRMustacheTemplate templateFromContentsOfFile:modelHeaderTemplatePath error:nil];
        GRMustacheTemplate *impTemplate = [GRMustacheTemplate templateFromContentsOfFile:modelImpTemplatePath error:nil];

        NSError *error = nil;
        NSString *headerOutput = [headerTemplate renderObject:[self objectFromModel:m] error:&error];
        NSString *impOutput = [impTemplate renderObject:[self objectFromModel:m] error:&error];

        if (error) {
            NSLog(@"MustacheError:%@",error);
        }
//        NSLog(@"output:%@",impOutput);
        
        
        [fm createDirectoryAtPath:self.outputPath  withIntermediateDirectories:YES attributes:nil error:NULL];
        NSString *hfilePath = [self.outputPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.h",m.modelName]];
        NSString *mfilePath = [self.outputPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m",m.modelName]];
        [headerOutput writeToFile:hfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [impOutput writeToFile:mfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
    }
    
    
    //copy support files
    NSArray *supportFiles = @[@"AHDefine.h",@"NSDictionary+MultiKeys.h",@"NSDictionary+MultiKeys.m"];
    
    NSString *supportPath = [self.outputPath stringByAppendingPathComponent:@"support"];
    
    [fm createDirectoryAtPath:supportPath  withIntermediateDirectories:YES attributes:nil error:NULL];

    for (NSString *file in supportFiles) {
        NSString *originFilePath = [[NSBundle mainBundle] pathForResource:file ofType:nil inDirectory:@"resource"];
        if (originFilePath) {
            NSString *content = [NSString stringWithContentsOfFile:originFilePath encoding:NSUTF8StringEncoding error:nil];
            NSString *outputPath = [supportPath stringByAppendingPathComponent:file];
            [content writeToFile:outputPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
    }
    

}



-(void)parseInput
{
    if ([self.input isKindOfClass:[NSArray class]]) {
        NSLog(@"parse input begin");
        
        for (JOService *service in self.input) {
            [self parseService:service];
        }
        
    }
}


-(void)parseService:(JOService*)service
{
    JORequestBody *request = service.request.body;
    JOResponseBody *response = service.response.body;
    [self parseValue:request.value withModel:[self modelForName:request.requestName]];
    [self parseValue:response.value withModel:[self modelForName:response.requestName]];
    
}

-(void)parseValue:(JOValue*)value withModel:(JOModel*)model
{
    if(value==nil)return;
    
    if (value.valueType == JOVALUE_TYPE_DICTIONARY) {
        //parse dictionary data as model property
        //value.value is NSArray of JOLink
        if ([value.value isKindOfClass:[NSArray class]]) {
            for (JOLink *link in value.value) {
                [self parseLink:link forModel:model];
            }
            
            
        }
    }
  
}

-(void)parseLink:(JOLink*)link forModel:(JOModel*)model
{
    if (link==nil) {
        return ;
    }
    
    JOProperty *property = [[JOProperty alloc] init];
    
    NSString *request_name = link.requestName;//name which server use
    NSString *type = link.assignmentExp.declareExp.type.typeName;
    NSString *subType = link.assignmentExp.declareExp.type.subtypeName;
    NSString *declareName = link.assignmentExp.declareExp.varName;
    JOValue *value = link.assignmentExp.value;
    
    BOOL hasSubType = !ISEMPTY_STR(subType);
    BOOL hasType = !ISEMPTY_STR(type);
    
    NSString *propertyName = request_name;
    if (ISEMPTY_STR(declareName) == NO) {
        propertyName = declareName;
    }
    
    
    NSString *propertyType;
    
    //set default value type according to value type
    switch (value.valueType) {
        case JOVALUE_TYPE_DICTIONARY:
            propertyType = @"NSDictionary*";
            break;
        case JOVALUE_TYPE_ARRAY:
            propertyType = @"NSArray*";
            break;
        case JOVALUE_TYPE_BOOL:
            propertyType = @"BOOL";
            break;
        case JOVALUE_TYPE_INT:
            propertyType = @"int";
        case JOVALUE_TYPE_DOUBLE:
            propertyType = @"double";
        default:
            propertyType = @"NSString*";
            break;
    }
    
    //set value type according to explicit type
    
    if (hasType) {
        if ([self isBasicType:type]) {
            propertyType = [self standardTypeName:type];
        }else if([self isNSBaseType:type]){
            propertyType = [self standardTypeName:type];
            
            //subtype is used for array
            if (value.valueType == JOVALUE_TYPE_ARRAY && hasSubType) {
                //all array element are of subtype
                JOModel *newmodel = [self modelForName:subType];
                for (JOValue *val in (NSArray*)(value.value)) {
                    [self parseValue:val withModel:newmodel];
                }
                [model importClass:subType];
                
            }else{
                //parse sub model
                [self parseValue:value withModel:nil];
            }
        }else{
            //user defined new object type
            propertyType = type;
            
            //add header
            [model importClass:type];
            
            //parse sub model
            JOModel *newmodel = [self modelForName:type];
            [self parseValue:value withModel:newmodel];
        }
    }
    
    
   
    [property addServerName:request_name];
    property.name = propertyName;
    property.type = propertyType;
    property.subType = subType;
    [self setDefaultAttributeForProperty:property];
    
    [model addProperty:property];
}


-(void)setDefaultAttributeForProperty:(JOProperty*)property
{
    BOOL hasAtomic = NO;
    BOOL hasStrongWeak = NO;
    NSArray *atomics = @[@"nonatomic",@"atomic"];
    NSArray *strongweaks = @[@"strong",@"retain",@"weak",@"assign"];
    for (NSString *att in property.attributes) {
        if ([atomics containsObject:att]) {
            hasAtomic = YES;
        }else if([strongweaks containsObject:att]){
            hasStrongWeak = YES;
        }
    }
    
    if (!hasAtomic) {
        [property addAttribute:@"nonatomic"];
    }
    if (!hasStrongWeak) {
        if ([self isBasicType:property.type]) {
            [property addAttribute:@"assign"];
        }else{
            [property addAttribute:@"strong"];
        }
    }
}

//convert basic type: intValue...
-(NSString*)funcNameForConvertType:(NSString*)type
{
    NSArray *ctypes = @[@"int",@"bool",@"double",@"float",@"boolean"];
    NSArray *converts =@[@"intValue",@"boolValue",@"doubleValue",@"floatValue",@"boolValue"];
    NSString *ty = [type lowercaseString];

    NSUInteger index = [ctypes indexOfObject:ty];
    if (index!=NSNotFound) {
        return converts[index];
    }
    NSLog(@"error, can't convert:%@",type);
    return nil;
}

-(NSString*)funcNameForEncodeType:(NSString*)type
{
    NSArray *ctypes = @[@"int",@"bool",@"double",@"float",@"boolean"];
    NSArray *converts =@[@"numberWithInt",@"numberWithBool",@"numberWithDouble",@"numberWithFloat",@"numberWithBool"];
    NSString *ty = [type lowercaseString];
    
    NSUInteger index = [ctypes indexOfObject:ty];
    if (index!=NSNotFound) {
        return converts[index];
    }
    NSLog(@"error, can't convert:%@",type);
    return nil;
}

-(BOOL)isBasicType:(NSString*)typeName
{
    NSArray *ctypes = @[@"int",@"bool",@"double",@"float",@"boolean"];

    NSString *ty = [typeName lowercaseString];
    return [ctypes containsObject:ty];
}

-(BOOL)isNSBaseType:(NSString*)typeName
{
    NSString *ty = [typeName lowercaseString];
    NSArray *types = @[@"nsarray",@"nsmutableArray",@"nsdictionary",@"nsstring",@"nsmutabledictionary"];
    return [types containsObject:ty];
}

-(BOOL)isNSArray:(NSString*)typeName
{
    NSString *ty = [typeName lowercaseString];
    return [ty isEqualToString:@"nsarray"];
}

-(NSString*)standardTypeName:(NSString*)typeName
{
    NSString *lowcaseTypeName = [typeName lowercaseString];
    
    if ([self isBasicType:typeName]) {
        NSArray *ctypes = @[@"int",@"bool",@"double",@"float",@"boolean"];
        NSArray *ctypesStr = @[@"int",@"BOOL",@"double",@"float",@"BOOL"];
        NSUInteger index = [ctypes indexOfObject:lowcaseTypeName];
        if (index!=NSNotFound) {
            return ctypesStr[index];
        }
        return typeName;
    }
    
    //object type
    if ([typeName rangeOfString:@"*"].length>0) {
        return typeName;
    }else{
        return [NSString stringWithFormat:@"%@*",typeName];
    }
    
}



-(id)objectFromModel:(JOModel *)model
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    
    NSMutableArray *headerArray = [NSMutableArray array];
    for (NSString *header in model.headerClasses) {
        NSDictionary *headdic = [NSDictionary dictionaryWithObject:header forKey:@"import_header"];
        [headerArray addObject:headdic];
    }
    
    NSMutableArray *propertyArray = [NSMutableArray array];

    NSMutableArray *propertyArray_dealloc = [NSMutableArray array];

    NSMutableArray *properties_value = [NSMutableArray array];
    
    for (JOProperty *p in model.properties) {
        [propertyArray addObject:[self objectFromProperty:p]];
        
        NSString *serverNames = [self stringForServerNames:p.serverNames];
        
        NSString *type = [p.type stringByReplacingOccurrencesOfString:@"*" withString:@""];
        
        if ([self isBasicType:type]) {
            [properties_value addObject:@{@"properties_setvalue_with_convert":@{
             @"property_name":p.name,
             @"property_type":p.type,
             @"property_server_names":serverNames,
             @"property_type_convert_func":[self funcNameForConvertType:type],
             @"property_type_reverse_convert_func":[self funcNameForEncodeType:type]

             }}];
            
        }else if([self isNSBaseType:type]){
            if ([self isNSArray:type] && p.subType) {
                [properties_value addObject:@{@"properties_setvalue_array":@{
                 @"property_name":p.name,
                 @"property_type":p.type,
                 @"property_subtype":p.subType,
                 @"property_server_names":serverNames
                 }}];
            }else{
                [properties_value addObject:@{@"properties_setvalue":@{
                 @"property_name":p.name,
                 @"property_type":p.type,
                 @"property_server_names":serverNames
                 }}];
            }
            [propertyArray_dealloc addObject:@{@"property_name":p.name}];
        }else{

            [properties_value addObject:@{@"properties_setvalue_obj":@{
             @"property_name":p.name,
             @"property_type":p.type,
             @"property_server_names":serverNames
             }}];
            [propertyArray_dealloc addObject:@{@"property_name":p.name}];

        }
    }
    
    
    [dic setObject:headerArray forKey:@"import_headers"];
    [dic setObject:propertyArray  forKey:@"properties"];
    [dic setObject:model.modelName forKey:@"class_name"];
    [dic setObject:model.project forKey:@"project_name"];
    [dic setObject:dateStr forKey:@"date"];
    
//    [dic setObject:propertyArray_convert forKey:@"properties_setvalue_with_convert"];
//    [dic setObject:propertyArray_sysobj forKey:@"properties_setvalue"];
//    [dic setObject:propertyArray_customobj forKey:@"properties_setvalue_obj"];
    [dic setObject:propertyArray_dealloc forKey:@"properties_dealloc"];
    [dic setObject:properties_value forKey:@"properties_value"];
    return dic;
    
    
}


-(NSString*)stringForServerNames:(NSArray*)serverNames
{
    NSMutableString *result = [NSMutableString string];
    for(int i=0;i<serverNames.count;++i){
        if (i==0) {
            [result appendFormat:@"@\"%@\"",serverNames[i]];
        }else{
            [result appendFormat:@",@\"%@\"",serverNames[i]];
        }
    }
    return result;
}

-(NSDictionary *)objectFromProperty:(JOProperty *)p
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSMutableString *attibutesStr = [NSMutableString string];
    for (int i = 0;i<p.attributes.count;++i) {
        NSString *att = p.attributes[i];
        if (i==0) {
            [attibutesStr appendString:att];
        }else{
            [attibutesStr appendFormat:@",%@",att ];
        }
    }
    
    [dic setObject:attibutesStr forKey:@"property_attributes"];
    [dic setObject:[self standardTypeName:p.type] forKey:@"property_type"];
    [dic setObject:p.name forKey:@"property_name"];
    
    return dic;
    
}

@end
