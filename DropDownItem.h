//
//  DropDownItem.h
//  Xiaozhima
//
//  Created by zhangqi on 15/11/18.
//  Copyright © 2015年 Xiaozhima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownItemModel.h"
@interface DropDownItem : UIControl
/** 主标题下各个单元格数据源 */
@property (strong, nonatomic) DropDownItemModel *itemModel;
/** 单元格下标 */
@property (assign, nonatomic) NSInteger itemIndex;
/** 单元格icon图片距离左视图间距 */
@property (assign, nonatomic) CGFloat iconImageLeftPadding;
/** 重设单元格界面视图 */
-(void)loadItems;
/** 呢荣单元格点击回调block */
@property (copy, nonatomic) void (^itemClickBlock)(NSInteger itemIndex);
@end
