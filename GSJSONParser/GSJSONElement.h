//
//  GSJSONElement.h
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSJSONType.h"

@interface GSJSONElement : NSObject

@property (nonatomic, strong) NSString *keyForJSON;
@property (nonatomic, strong) NSString *keyForObject;
@property (nonatomic, strong) GSJSONType *type;

+ (GSJSONElement *) elementWithKey:(NSString *)key elementType:(GSJSONType *)type;

+ (GSJSONElement *) GSInt:(NSString *)key;
+ (GSJSONElement *) GSLong:(NSString *)key;
+ (GSJSONElement *) GSBoolean:(NSString *)key;
+ (GSJSONElement *) GSDouble:(NSString *)key;
+ (GSJSONElement *) GSFloat:(NSString *)key;
+ (GSJSONElement *) GSString:(NSString *)key;
+ (GSJSONElement *) GSArray:(NSString *)key class:(Class)classN;
+ (GSJSONElement *) GSArrayArray:(NSString *)key class:(Class)classN;
+ (GSJSONElement *) GSDictionay:(NSString *)key class:(Class)classN;
+ (GSJSONElement *) GSDictionayDictionay:(NSString *)key class:(Class)classN;
+ (GSJSONElement *) GSObject:(NSString *)key class:(Class)classN;
+ (GSJSONElement *) GSDate:(NSString *)key class:(Class)classN;
+ (GSJSONElement *) GSDateFormat:(NSString *)key format:(NSString *)format;
+ (GSJSONElement *) GSDateFormat:(NSString *)key format:(NSString *)format timeZone:(NSString *)timeZone ;

+ (GSJSONElement *) GSID:(NSString *)key;

@end
