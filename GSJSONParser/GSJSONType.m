//
//  GSJSONType.m
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import "GSJSONType.h"

@implementation GSJSONType

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
    [GSJSONType class];
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeArray;
    jsonType.objectClass = class;
    return jsonType;
}

+ (GSJSONType *)dictionary {
    return [GSJSONType dictionaryWithClass:nil];
}

+ (GSJSONType *)dictionaryWithClass:(Class )class{
    [GSJSONType class];
    GSJSONType *jsonType = [GSJSONType new];
    jsonType.elementType = GSJSONElementTypeDictionary;
    jsonType.objectClass = class;
    return jsonType;
}

@end
