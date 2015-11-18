//
//  DropDownItemDataTool.h
//  Template
//
//  Created by caimiao on 15/11/16.
//  Copyright © 2015年 iOS developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DropDownItemDataTool : NSObject
+(void)getTestDataWithSuccess:(void(^)(NSArray *itemArray))success Failure:(void(^)(NSError *error))failure;
@end
