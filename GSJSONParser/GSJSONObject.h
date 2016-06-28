//
//  GSJSon.h
//  ZAccountKit
//
//  Created by Gantulga on 6/28/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSJSONElement.h"

@interface GSJSONObject : NSObject

- (id) initWithDictionary:(NSDictionary *)dictionary ;
- (NSArray <GSJSONElement *> *) elementArray ;
@end
