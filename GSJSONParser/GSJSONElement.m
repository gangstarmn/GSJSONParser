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

@end
