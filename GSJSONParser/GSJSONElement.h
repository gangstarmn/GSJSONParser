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

@end
