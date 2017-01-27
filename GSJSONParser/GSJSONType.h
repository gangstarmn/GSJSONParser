//
//  GSJSONType.h
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, GSJSONElementType) {
    GSJSONElementTypeInt,
    GSJSONElementTypeBoolean,
    GSJSONElementTypeDouble,
    GSJSONElementTypeFloat,
    GSJSONElementTypeString,
    GSJSONElementTypeArray,
    GSJSONElementTypeArrayArray,
    GSJSONElementTypeDictionary,
    GSJSONElementTypeDictionaryDictionary,
    GSJSONElementTypeObject,

};

@interface GSJSONType : NSObject
@property (nonatomic, assign) GSJSONElementType elementType;
@property (nonatomic, assign) Class objectClass;

+ (GSJSONType *)simpleTypeWithType:(GSJSONElementType )type;
+ (GSJSONType *)simpleTypeWithClass:(Class )class ;

+ (GSJSONType *)array;
+ (GSJSONType *)arrayWithClass:(Class )class;
+ (GSJSONType *)arrayArrayWithClass:(Class )class;

+ (GSJSONType *)dictionary;
+ (GSJSONType *)dictionaryWithClass:(Class )class;
+ (GSJSONType *)dictionaryDictionaryWithClass:(Class )class;

@end
