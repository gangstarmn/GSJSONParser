//
//  GSJSONType.m
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import "GSJSONType.h"
#import <GSLog/GSLog.h>

@implementation GSJSONType

static NSString *defaultDateFormat = @"yyyy-MM-dd HH:mm:ss";

+ (void) setDateDefaultFormat :(NSString *) format {
    defaultDateFormat = format;
}

+ (GSJSONType *)date {
    return [GSJSONType dateWithFormat:defaultDateFormat];
}

+ (GSJSONType *)dateWithFormat:(NSString *)dateFormat {
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeDate;
    jsonType.dateFormat = dateFormat;
    return jsonType;
}

+ (GSJSONType *)simpleTypeWithType:(GSJSONElementType )type {
    if (type == GSJSONElementTypeObject) {
        ATLog(@"Don't use this method on GSJSONElementTypeObject type ");
        return nil;
    }
    
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = type;
    return jsonType;
}

+ (GSJSONType *)simpleTypeWithClass:(Class )class {
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeObject;
    jsonType.objectClass = class;
    return jsonType;
}

+ (GSJSONType *)array {
    return [GSJSONType arrayWithClass:nil];
}

+ (GSJSONType *)arrayWithClass:(Class )class{
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeArray;
    jsonType.objectClass = class;
    return jsonType;
}

+ (GSJSONType *)arrayArrayWithClass:(Class )class {
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeArrayArray;
    jsonType.objectClass = class;
    return jsonType;
}

+ (GSJSONType *)dictionary {
    return [GSJSONType dictionaryWithClass:nil];
}

+ (GSJSONType *)dictionaryWithClass:(Class )class{
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeDictionary;
    jsonType.objectClass = class;
    return jsonType;
}
+ (GSJSONType *)dictionaryDictionaryWithClass:(Class )class {
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeDictionaryDictionary;
    jsonType.objectClass = class;
    return jsonType;
}
@end
