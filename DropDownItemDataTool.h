//
//  DropDownItemDataTool.h
//  Xiaozhima
//
//  Created by zhangqi on 15/11/18.
//  Copyright © 2015年 Xiaozhima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DropDownItemDataTool : NSObject
+(void)getTestDataWithSuccess:(void(^)(NSArray *itemArray))success Failure:(void(^)(NSError *error))failure;
@end
