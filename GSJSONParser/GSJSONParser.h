//
//  GSJSONParser.h
//  GSJSONParser
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 ZTech LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSJSONObject.h"
#import "NSMutableArray+GSExtention.h"
#import "NSMutableDictionary+GSExtention.h"

#define GSInt(key)                  [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeInt]]
#define GSBoolean(key)              [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeBoolean]]
#define GSDouble(key)               [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeDouble]]
#define GSFloat(key)                [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeFloat]]
#define GSString(key)               [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithType:GSJSONElementTypeString]]

#define GSArray(key,class)          [GSJSONElement elementWithKey:key elementType:[GSJSONType arrayWithClass:class]]
#define GSArrayArray(key,class)          [GSJSONElement elementWithKey:key elementType:[GSJSONType arrayArrayWithClass:class]]

#define GSDictionay(key,class)            [GSJSONElement elementWithKey:key elementType:[GSJSONType dictionaryWithClass:class]]
#define GSDictionayArray(key,class)            [GSJSONElement elementWithKey:key elementType:[GSJSONType dictionaryArrayWithClass:class]]

#define GSDictionayDictionay(key,class)   [GSJSONElement elementWithKey:key elementType:[GSJSONType dictionaryDictionaryWithClass:class]]
#define GSObject(key,class)               [GSJSONElement elementWithKey:key elementType:[GSJSONType simpleTypeWithClass:class]]

#define GSDate(key) [GSJSONElement elementWithKey:key elementType:[GSJSONType date]]
#define GSDateFormat(key, format) [GSJSONElement elementWithKey:key elementType:[GSJSONType dateWithFormat:format]]
#define GSID(key)               [GSJSONElement GSID:key]
