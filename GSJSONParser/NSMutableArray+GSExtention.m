//
//  NSArray+GSExtention.m
//  Pods
//
//  Created by Gantulga on 6/17/16.
//
//

#import "NSMutableArray+GSExtention.h"
#import "NSMutableDictionary+GSExtention.h"

@implementation NSMutableArray (GSExtention)

- (void) removeAllNull {
    for (NSUInteger i = 0; i < [self count]; i ++) {
        id object = [self objectAtIndex:i];
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:object];
            [dictionary removeAllNull];
            [self replaceObjectAtIndex:i withObject:dictionary];
        }
        else if ([object isKindOfClass:[NSArray class]]) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:object];
            [array removeAllNull];
            [self replaceObjectAtIndex:i withObject:array];
        }
    }
}
@end
