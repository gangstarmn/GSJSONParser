//
//  NSDictionary+GSExtention.m
//  ZAccountKit
//
//  Created by Gantulga on 6/17/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import "NSMutableDictionary+GSExtention.h"
#import "NSMutableArray+GSExtention.h"
@implementation NSMutableDictionary (GSExtention)

- (void)removeAllNull {
    NSArray *keysForNullValues = [self allKeysForObject:[NSNull null]];
    [self removeObjectsForKeys:keysForNullValues];
    NSArray <NSString *> *allKeys = [self allKeys];
    for (NSString *key in allKeys) {
        id object = [self objectForKey:key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:object];
            [dictionary removeAllNull];
            [self setObject:dictionary forKey:key];
        }
        else if ([object isKindOfClass:[NSArray class]]) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:object];
            [array removeAllNull];
            [self setObject:array forKey:key];
            
        }
    }
}

- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
    else {
        [self setObject:[NSNull null] forKey:aKey];
    }
}

@end
