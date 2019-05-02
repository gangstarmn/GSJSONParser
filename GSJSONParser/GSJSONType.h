//
//  GSJSONType.h
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, GSJSONElementType) {
    GSJSONElementTypeDate,
    GSJSONElementTypeInt,
    GSJSONElementTypeLong,
    GSJSONElementTypeBoolean,
    GSJSONElementTypeDouble,
    GSJSONElementTypeFloat,
    GSJSONElementTypeString,
    GSJSONElementTypeArray,
    GSJSONElementTypeArrayArray,
    GSJSONElementTypeDictionary,
    GSJSONElementTypeDictionaryArray,
    GSJSONElementTypeDictionaryDictionary,
    GSJSONElementTypeObject,
    GSJSONElementTypeID,
};

@interface GSJSONType : NSObject
@property (nonatomic, assign) GSJSONElementType elementType;
@property (nonatomic, assign) Class objectClass;
@property (nonatomic, strong) NSString *dateFormat;
@property (nonatomic, strong) NSString *timeZone;

+ (void) setDateDefaultFormat :(NSString *) format ;
+ (GSJSONType *)type;
+ (GSJSONType *)date;
+ (GSJSONType *)dateWithFormat:(NSString *)dateFormat;
+ (GSJSONType *)dateWithFormat:(NSString *)dateFormat timeZone:(NSString *)timeZone;

+ (GSJSONType *)simpleTypeWithType:(GSJSONElementType )type;
+ (GSJSONType *)simpleTypeWithClass:(Class )classN ;

+ (GSJSONType *)array;
+ (GSJSONType *)arrayWithClass:(Class )classN;
+ (GSJSONType *)arrayArrayWithClass:(Class )classN;

+ (GSJSONType *)dictionary;
+ (GSJSONType *)dictionaryWithClass:(Class )classN;
+ (GSJSONType *)dictionaryArrayWithClass:(Class )classN;
+ (GSJSONType *)dictionaryDictionaryWithClass:(Class )classN;

@end
