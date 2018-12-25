//
//  GSJSONElement.m
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import "GSJSONElement.h"

@implementation GSJSONElement

+ (GSJSONElement *) elementWithKey:(NSString *)key elementType:(GSJSONType *)type {
    GSJSONElement *element = [GSJSONElement new];
    element.keyForJSON = key;
    element.keyForObject = key;
    element.type = type;
    return element;
}

+ (GSJSONElement *) GSInt:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeInt]];
}

+ (GSJSONElement *) GSLong:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeLong]];
}

+ (GSJSONElement *) GSBoolean:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeBoolean]];
}

+ (GSJSONElement *) GSDouble:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeDouble]];
}

+ (GSJSONElement *) GSFloat:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeFloat]];
}

+ (GSJSONElement *) GSString:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeString]];
}

+ (GSJSONElement *) GSArray:(NSString *)key class:(Class)class {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType arrayWithClass:class]];
}

+ (GSJSONElement *) GSArrayArray:(NSString *)key class:(Class)class {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType arrayArrayWithClass:class]];
}

+ (GSJSONElement *) GSDictionay:(NSString *)key class:(Class)class {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType dictionaryWithClass:class]];
}

+ (GSJSONElement *) GSDictionayDictionay:(NSString *)key class:(Class)class {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType dictionaryDictionaryWithClass:class]];
}

+ (GSJSONElement *) GSObject:(NSString *)key class:(Class)class {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithClass:class]];
}

+ (GSJSONElement *) GSDate:(NSString *)key class:(Class)class {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType date]];
}

+ (GSJSONElement *) GSDateFormat:(NSString *)key format:( NSString *)format {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType dateWithFormat:format]];
}

+ (GSJSONElement *) GSID:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType type]];
}

@end
