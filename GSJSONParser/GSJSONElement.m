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

+ (GSJSONElement *) GSArray:(NSString *)key class:(Class)classN {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType arrayWithClass:classN]];
}

+ (GSJSONElement *) GSArrayArray:(NSString *)key class:(Class)classN {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType arrayArrayWithClass:classN]];
}

+ (GSJSONElement *) GSDictionay:(NSString *)key class:(Class)classN {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType dictionaryWithClass:classN]];
}

+ (GSJSONElement *) GSDictionayDictionay:(NSString *)key class:(Class)classN {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType dictionaryDictionaryWithClass:classN]];
}

+ (GSJSONElement *) GSObject:(NSString *)key class:(Class)classN {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithClass:classN]];
}

+ (GSJSONElement *) GSDate:(NSString *)key class:(Class)classN {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType date]];
}

+ (GSJSONElement *) GSDateFormat:(NSString *)key format:( NSString *)format {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType dateWithFormat:format]];
}

+ (GSJSONElement *) GSDateFormat:(NSString *)key format:(NSString *)format timeZone:(NSString *)timeZone {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType dateWithFormat:format timeZone:timeZone]];
}

+ (GSJSONElement *) GSID:(NSString *)key {
    return [GSJSONElement elementWithKey:key elementType:[GSJSONType type]];
}

@end
