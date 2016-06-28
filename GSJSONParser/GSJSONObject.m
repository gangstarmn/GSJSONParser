//
//  GSJSon.m
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import "GSJSONObject.h"
@implementation GSJSONObject

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSArray *elementArray = [self elementArray];
        if ([elementArray count] == 0) {
            ATLogWarning(@"Element Array not defined");
        }
        for (GSJSONElement *element in elementArray) {
            id value = [dictionary objectForKey:element.keyForJSON];
            if (value) {
                if (element.type.elementType == GSJSONElementTypeInt || element.type.elementType == GSJSONElementTypeBoolean || element.type.elementType == GSJSONElementTypeDouble || element.type.elementType == GSJSONElementTypeFloat) {
                    if ([value isKindOfClass:[NSNumber class]]) {
                        [self setValue:value forKey:element.keyForObject];
                    }
                    else {
                        ATLogError(@"%@ is not a NSNumber",element.keyForJSON);
                    }
                }
                else if (element.type.elementType == GSJSONElementTypeString) {
                    if ([value isKindOfClass:[NSString class]]) {
                        [self setValue:value forKey:element.keyForObject];
                    }
                    else {
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
                                [self setValue:tempArray forKey:element.keyForObject];
                            }
                            else {
                                ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
                            }
                        }
                        else {
                            [self setValue:value forKey:element.keyForObject];
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
                                [self setValue:tempDictionary forKey:element.keyForObject];
                            }
                            else {
                                ATLogError(@"%@ is not a kind of class GSJSONObject",element.type.objectClass);
                            }
                        }
                        else {
                            [self setValue:value forKey:element.keyForObject];
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
                                [self setValue:object forKey:element.keyForObject];
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

- (NSMutableArray <GSJSONElement *> *) elementArray  {
    return [NSMutableArray array];
}
@end
