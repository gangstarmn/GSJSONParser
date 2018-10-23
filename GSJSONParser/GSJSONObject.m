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

+ (NSMutableArray <GSJSONElement *> *) elementArrayForClass :(Class )class {
    if (!tClassElementArray) {
        tClassElementArray = [NSMutableDictionary dictionary];
    }
    NSMutableArray <GSJSONElement *> *eArray = tClassElementArray[NSStringFromClass(class)];
    if (!eArray) {
        eArray = [class elementArray];
        [tClassElementArray setObject:eArray forKey:NSStringFromClass(class)];
    }
    return eArray;
}

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSArray <GSJSONElement *> *elementArray = [GSJSONObject elementArrayForClass:self.class];
        if ([elementArray count] == 0) {
            ATLogWarning(@"Element Array not defined");
        }
        for (GSJSONElement *element in elementArray) {
            id value = [dictionary objectForKey:element.keyForJSON];
            if (value) {
                if (element.type.elementType == GSJSONElementTypeInt || element.type.elementType == GSJSONElementTypeBoolean || element.type.elementType == GSJSONElementTypeDouble || element.type.elementType == GSJSONElementTypeFloat) {
                    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
                        [self setSafeValue:value forKey:element.keyForObject];
                    }
                    else {
                        ATLogError(@"%@ is not a NSNumber",element.keyForJSON);
                    }
                }
                else if (element.type.elementType == GSJSONElementTypeString) {
                    if ([value isKindOfClass:[NSString class]]) {
                        [self setSafeValue:value forKey:element.keyForObject];
                    }
                    else {
                        ATLogError(@"%@ is not a NSString",element.keyForJSON);
                    }
                }
                else if (element.type.elementType == GSJSONElementTypeDate) {
                    if ([value isKindOfClass:[NSString class]]) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:element.type.dateFormat];
                        NSDate *date = [dateFormatter dateFromString:value];
                        [self setSafeValue:date forKey:element.keyForObject];
                    }
                    else
                    {
                        ATLogError(@"%@ is not a NSString",element.keyForJSON);
                    }
                }
                else if (element.type.elementType == GSJSONElementTypeArray) {
                    if ([value isKindOfClass:[NSArray class]]) {
                        if (element.type.objectClass) {
                            if ([[self class] isSubclassOfClass:element.type.objectClass]) {
                                ATLogError(@"subclass %@",[self class]);
                            }
                            if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                                NSArray <NSDictionary *> *array = value;
                                NSMutableArray *tempArray = [NSMutableArray array];
                                for (NSDictionary *subDictionary in array) {
                                    GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:subDictionary];
                                    [tempArray addObject:object];
                                }
                                [self setSafeValue:tempArray forKey:element.keyForObject];
                            }
                            else {
                                ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
                            }
                        }
                        else {
                            [self setSafeValue:value forKey:element.keyForObject];
                        }
                    }
                    else {
                        ATLogError(@"%@ is not a NSArray",element.keyForJSON);
                    }
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
                                [self setSafeValue:tempArray forKey:element.keyForObject];
                            }
                            else {
                                ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
                            }
                        }
                        else {
                            [self setSafeValue:value forKey:element.keyForObject];
                        }
                    }
                    else {
                        ATLogError(@"%@ is not a NSArray",element.keyForJSON);
                    }
                }
                else if (element.type.elementType == GSJSONElementTypeDictionary) {
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        if (element.type.objectClass) {
                            if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                                NSDictionary <NSString *, NSDictionary *> *valueDictionary = value;
                                NSArray <NSString *> *allKeys = [valueDictionary allKeys];
                                NSMutableDictionary<NSString *, GSJSONObject *> *tempDictionary = [NSMutableDictionary dictionary];
                                for (NSString *key in allKeys) {
                                    GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:[valueDictionary objectForKey:key]];
                                    [tempDictionary setObject:object forKey:key];
                                }
                                [self setSafeValue:tempDictionary forKey:element.keyForObject];
                            }
                            else {
                                ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
                            }
                        }
                        else {
                            [self setSafeValue:value forKey:element.keyForObject];
                        }
                    }
                    else {
                        ATLogError(@"%@ is not a NSDictionary",element.keyForJSON);
                    }
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
                            
                            [self setSafeValue:tempDictionary forKey:element.keyForObject];
                        }
                        else {
                            ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
                        }
                    }
                    else {
                        ATLogError(@"%@ is not a NSDictionary",element.keyForJSON);
                    }
                }
                else if (element.type.elementType == GSJSONElementTypeObject) {
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        if (element.type.objectClass) {
                            if ([element.type.objectClass isSubclassOfClass:[GSJSONObject class]]) {
                                GSJSONObject *object = [[element.type.objectClass alloc] initWithDictionary:value];
//                                ATLogError(@"GSJSONObject %@",[object valueForKey:@"size"]);
                                [self setSafeValue:object forKey:element.keyForObject];
                            }
                            else {
                                ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
                            }
                        }
                        else {
                            ATLogError(@"element.type.objectClass Not Defined ");
                        }
                    }
                    else {
                        ATLogError(@"%@ is not a NSDictionary",element.keyForJSON);
                    }
                }
            }
        }
    }
    return self;
}
- (void) setSafeValue:(id)value forKey:(NSString *)key {
    if ([self respondsToSelector:NSSelectorFromString(key)]) {
        [self setValue:value forKey:key];
    }
    else {
        ATLog(@"%@ key is Not Defined in %@", key, [self class]);
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

+ (NSMutableArray <GSJSONElement *> *) elementArray  {
    return [NSMutableArray array];
}

- (NSDictionary *)dictionaryValue {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray <GSJSONElement *> *elementArray = [GSJSONObject elementArrayForClass:self.class];
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
