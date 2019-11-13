//
//  GSJSon.m
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import "GSJSONObject.h"
#import <GSLog/GSLog.h>
#import <UIKit/UIKit.h>

@implementation GSJSONObject

static NSMutableDictionary<NSString *, NSMutableArray <GSJSONElement *> *> *tClassElementArray = nil;

+ (NSMutableArray <GSJSONElement *> *) elementArrayForClass :(GSJSONObject *)object {
    if (!tClassElementArray) {
        tClassElementArray = [NSMutableDictionary dictionary];
    }
    NSMutableArray <GSJSONElement *> *eArray = tClassElementArray[NSStringFromClass(object.class)];
    if (!eArray) {
        eArray = [object elementArray];
        [tClassElementArray setObject:eArray forKey:NSStringFromClass(object.class)];
    }
    return eArray;
}

+ (id) getParsedValue:(id)value element :(GSJSONElement *)element {
    if (element.type.elementType == GSJSONElementTypeID) {
        return value;
    }
    else if (element.type.elementType == GSJSONElementTypeInt ||
             element.type.elementType == GSJSONElementTypeBoolean ||
             element.type.elementType == GSJSONElementTypeDouble ||
             element.type.elementType == GSJSONElementTypeFloat ||
             element.type.elementType == GSJSONElementTypeLong) {
        if ([value isKindOfClass:[NSNumber class]] ||
            [value isKindOfClass:[NSString class]]) return value;
        else ATLogError(@"%@ is not a NSNumber",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeString) {
        if ([value isKindOfClass:[NSString class]]) return value;
        else ATLogError(@"%@ is not a NSString",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeDate) {
        if ([value isKindOfClass:[NSString class]]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:element.type.dateFormat];
            if (element.type.timeZone) {
                NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:element.type.timeZone];
                [dateFormatter setTimeZone:timeZone];
            }
            return [dateFormatter dateFromString:value];
        }
        else ATLogError(@"%@ is not a NSString",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeArray) {
        if ([value isKindOfClass:[NSArray class]]) {
            if (element.type.objectClass) {
                if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                    NSArray <NSDictionary *> *array = value;
                    NSMutableArray *tempArray = [NSMutableArray array];
                    for (NSDictionary *subDictionary in array) {
                        GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:subDictionary];
                        [tempArray addObject:object];
                    }
                    return tempArray;
                }
                else ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
            }
            else return value;
        }
        else ATLogError(@"%@ is not a NSArray",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeArrayArray) {
        if ([value isKindOfClass:[NSArray class]]) {
            if (element.type.objectClass) {
                if ([[self class] isSubclassOfClass:element.type.objectClass]) {
                    ATLogError(@"subclass %@",[self class]);
                }
                if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                    NSArray <NSArray <NSDictionary *> *> *array = value;
                    NSMutableArray <NSMutableArray <GSJSONObject *> *> *tempArray = [NSMutableArray array];
                    for (NSArray <NSDictionary *> *subArray in array) {
                        NSMutableArray <GSJSONObject *> *tempRowArray = [NSMutableArray array];
                        for (NSDictionary *subDictionary in subArray) {
                            GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:subDictionary];
                            [tempRowArray addObject:object];
                        }
                        [tempArray addObject:tempRowArray];
                    }
                    return tempArray;
                }
                else ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
            }
            else return value;
        }
        else ATLogError(@"%@ is not a NSArray",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeDictionary) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            if (element.type.objectClass) {
                if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                    NSDictionary <NSString *, NSDictionary *> *valueDictionary = value;
                    NSArray <NSString *> *allKeys = [valueDictionary allKeys];
                    NSMutableDictionary<NSString *, GSJSONObject *> *tempDictionary = [NSMutableDictionary dictionary];
                    for (NSString *key in allKeys) {
                        id valueDic = [valueDictionary objectForKey:key];
                        if ([valueDic isKindOfClass:[NSDictionary class]]) {
                            GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:valueDic];
                            [tempDictionary setObject:object forKey:key];
                        }
                    }
                    return tempDictionary;
                }
                else ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
            }
            else return value;
        }
        else ATLogError(@"%@ is not a NSDictionary",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeDictionaryArray) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            if (element.type.objectClass) {
                if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                    NSDictionary <NSString *, NSArray *> *valueDictionary = value;
                    NSArray <NSString *> *allKeys = [valueDictionary allKeys];
                    NSMutableDictionary<NSString *, NSArray <GSJSONObject *>*> *tempDictionary = [NSMutableDictionary dictionary];
                    for (NSString *key in allKeys) {
                        NSArray <NSDictionary *> *dArray = [valueDictionary objectForKey:key];
                        if ([dArray isKindOfClass:[NSArray class]]) {
                            NSMutableArray <GSJSONObject *> *tempArray = [NSMutableArray array];
                            for (NSDictionary *dic in dArray) {
                                [tempArray addObject:[[element.type.objectClass alloc] initWithDictionary:dic]];
                            }
                            [tempDictionary setObject:tempArray forKey:key];
                        }
                    }
                    return tempDictionary;
                }
                else ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
            }
            else return value;
        }
        else ATLogError(@"%@ is not a NSDictionary",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeDictionaryDictionary) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                
                NSMutableDictionary <NSString *, NSDictionary <NSString*, GSJSONObject *> *> *tempDictionary = [NSMutableDictionary dictionary];
                
                NSDictionary <NSString *, NSDictionary <NSString*, NSDictionary *> *> *valueDictionary = value;
                
                NSArray <NSString *> *allKeys = [valueDictionary allKeys];
                for (NSString *key in allKeys) {
                    
                    NSDictionary <NSString*, NSDictionary *> *subValueDictionary = [valueDictionary objectForKey:key];
                    if ([subValueDictionary isKindOfClass:[NSDictionary class]]) {
                        
                        NSMutableDictionary <NSString *, GSJSONObject *> *subTempDictionary = [NSMutableDictionary dictionary];
                        
                        NSArray <NSString *> *subKeys = [subValueDictionary allKeys];
                        
                        for (NSString *subKey in subKeys) {
                            NSDictionary *subSubDictionary = [subValueDictionary objectForKey:subKey];
                            
                            if ([subSubDictionary isKindOfClass:[NSDictionary class]]) {
                                GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:subSubDictionary];
                                [subTempDictionary setObject:object forKey:subKey];
                            }
                            else {
                                ATLogError(@"%@ is not a kind of class NSDictionary",subKey);
                            }
                        }
                        [tempDictionary setObject:subTempDictionary forKey:key];
                    }
                    else {
                        ATLogError(@"%@ is not a kind of class NSDictionary",key);
                    }
                }
                return tempDictionary;
            }
            else ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
        }
        else ATLogError(@"%@ is not a NSDictionary",element.keyForJSON);
    }
    else if (element.type.elementType == GSJSONElementTypeObject) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            if (element.type.objectClass) {
                if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                    GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:value];
                    return object;
                }
                else ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
            }
            else ATLogError(@"element.type.objectClass Not Defined ");
        }
        else ATLogError(@"%@ is not a NSDictionary",element.keyForJSON);
    }
    
    return nil;

}

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSArray <GSJSONElement *> *elementArray = [GSJSONObject elementArrayForClass:self];
        if ([elementArray count] == 0) {
            ATLogWarning(@"Element Array not defined");
        }
        for (GSJSONElement *element in elementArray) {
            id value = [dictionary objectForKey:element.keyForJSON];
            if (value) {
                id val = [GSJSONObject getParsedValue:value element:element];
                [self setSafeValue:val forKey:element.keyForObject];
            }
        }
    }
    return self;
}

- (void) setSafeValue:(id)value forKey:(NSString *)key {
    if (value) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:value forKey:key];
        }
        else {
            ATLog(@"%@ key is Not Defined in %@", key, [self class]);
        }
    }
    else {
        ATLog(@"the value is null %@ %@", key, [self class]);
    }
}

- (id) getSafeValueForKey:(NSString *)key{
    if ([self respondsToSelector:NSSelectorFromString(key)]) {
        return [self valueForKey:key];
//        [self setValue:value forKey:key];
    }
    else {
        ATLog(@"%@ key is Not Defined in %@", key, [self class]);
    }
    return nil;
}

- (NSMutableArray <GSJSONElement *> *) elementArray  {
    return [NSMutableArray array];
}

- (NSDictionary *)dictionaryValue {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray <GSJSONElement *> *elementArray = [GSJSONObject elementArrayForClass:self];
    if ([elementArray count] == 0) {
        ATLogWarning(@"Element Array not defined");
    }
    for (GSJSONElement *element in elementArray) {
        id value = [self getSafeValueForKey:element.keyForObject];
        if (value) {
            if (element.type.elementType == GSJSONElementTypeInt) {
                [dictionary setObject:value forKey:element.keyForJSON];
            }
            else if (element.type.elementType == GSJSONElementTypeBoolean) {
                [dictionary setObject:value forKey:element.keyForJSON];
            }
            else if (element.type.elementType == GSJSONElementTypeDouble) {
                [dictionary setObject:value forKey:element.keyForJSON];
            }
            else if (element.type.elementType == GSJSONElementTypeFloat) {
                [dictionary setObject:value forKey:element.keyForJSON];
            }
            else if (element.type.elementType == GSJSONElementTypeString) {
                [dictionary setObject:value forKey:element.keyForJSON];
            }
            else if (element.type.elementType == GSJSONElementTypeDate) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:element.type.dateFormat];
                NSString *stringDate = [formatter stringFromDate:value];
                [dictionary setObject:stringDate forKey:element.keyForJSON];
            }
            else if (element.type.elementType == GSJSONElementTypeObject) {
                GSJSONObject *object = (GSJSONObject *) value;
                [dictionary setObject:[object dictionaryValue] forKey:element.keyForJSON];
            }
            else if (element.type.elementType == GSJSONElementTypeArray) {
                if (element.type.objectClass) {
                    NSArray <GSJSONObject *> *array = (NSArray *)value;

                    NSMutableArray <NSDictionary *> *tempArray = [NSMutableArray array];
                    for (GSJSONObject *object in array) {
                        [tempArray addObject:[object dictionaryValue]];
                    }
                    [dictionary setObject:tempArray forKey:element.keyForJSON];
                }
                else {
                    [dictionary setObject:value forKey:element.keyForJSON];
                }
            }
            else if (element.type.elementType == GSJSONElementTypeDictionary) {
                if (element.type.objectClass) {
                    NSDictionary<NSString *, GSJSONObject *> *valueDictionary = (NSDictionary<NSString *,GSJSONObject *> *)value;

                    NSMutableDictionary <NSString *, NSDictionary *> *tempDictionary = [NSMutableDictionary dictionary];

                    NSArray <NSString *> *allKeys = [valueDictionary allKeys];
                    for (NSString *key in allKeys) {
                        GSJSONObject *object = [valueDictionary objectForKey:key];
                        [tempDictionary setObject:[object dictionaryValue] forKey:key];
                    }
                    [dictionary setObject:tempDictionary forKey:element.keyForJSON];
                }
                else {
                    [dictionary setObject:value forKey:element.keyForJSON];
                }
            }
            else if (element.type.elementType == GSJSONElementTypeDictionaryDictionary) {
                if (element.type.objectClass) {
                    NSDictionary <NSString *, NSDictionary <NSString*, GSJSONObject *> *> *valueDictionary = (NSDictionary <NSString *, NSDictionary <NSString*, GSJSONObject *> *> *)value;
                    
                    NSMutableDictionary <NSString *, NSDictionary <NSString*, NSDictionary *> *> *tempDictionary = [NSMutableDictionary dictionary];

                    NSArray <NSString *> *allKeys = [valueDictionary allKeys];
                    for (NSString *key in allKeys) {
                        NSDictionary <NSString*, GSJSONObject *> *subDictionary = [valueDictionary objectForKey:key];
                        NSMutableDictionary <NSString*, NSDictionary *> *subTempDictionary = [NSMutableDictionary dictionary];
                        
                        NSArray <NSString *> *subAllKeys = [subDictionary allKeys];
                        
                        for (NSString *subKey in subAllKeys) {
                            GSJSONObject *object = [subDictionary objectForKey:subKey];
                            
                            [subTempDictionary setObject:[object dictionaryValue] forKey:subKey];
                        }
                        
                        [tempDictionary setObject:subTempDictionary forKey:key];
                    }
                    [dictionary setObject:tempDictionary forKey:element.keyForJSON];
                }
                else {
                    [dictionary setObject:value forKey:element.keyForJSON];
                }
            }
            else if (element.type.elementType == GSJSONElementTypeDictionaryDictionary) {
                if (element.type.objectClass) {
                    GSJSONObject *object = (GSJSONObject *)value;
                    [dictionary setObject:object forKey:element.keyForJSON];

                }
                else {
                    [dictionary setObject:value forKey:element.keyForJSON];
                }
            }
        }
    }
    return dictionary;
}

@end
