//
//  DropDownItemManager.h
//  Xiaozhima
//
//  Created by zhangqi on 15/11/18.
//  Copyright © 2015年 Xiaozhima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownItemModel.h"
/** 枚举 单元格倾斜方向*/
typedef NS_ENUM(NSUInteger,DropDownItemTilt){
    DropDownItemTiltNone = 0,
    DropDownItemTiltLeft = 1,
    DropDownItemTiltRight = 2,
    DropDownItemTiltRandom = 3
};
/** 枚举 单元格显示及消失方向 */
typedef NS_ENUM(NSUInteger,DropDownItemShowLostDirection){
    DropDownItemShowLostDirectionNone = 0,
    DropDownItemShowLostDirectionLeft = 1,
    DropDownItemShowLostDirectionRight = 2,
    DropDownItemShowLostDirectionBoth = 3
};
@interface DropDownItemManager : UIControl
/** 枚举对象 */
@property (assign, nonatomic) DropDownItemTilt tilt;
@property (assign, nonatomic) DropDownItemShowLostDirection direction;
/** 主标题单元格点击block回调 */
@property (copy, nonatomic) void (^mainTitleSelectedBlock)(UIControl *self);
/** 内容单元格点击block回调 */
@property (copy, nonatomic) void (^selectedItemBlock)(NSInteger column,NSInteger index);
/** 主标题单元格数据源 */
@property (strong, nonatomic) DropDownItemModel *dropDownItemTitleModel;
/** 主标题下所有内容单元格数据源 */
@property (strong, nonatomic) NSArray *dropDownItemConnectArray;
/** 单元格icon图片距离左视图间距 */
@property (assign, nonatomic) CGFloat iconImageLeftPadding;
/** 单元格上下间距 */
@property (assign, nonatomic) CGFloat itemSpace;
/** 是否展开下拉菜单 */
@property (assign, nonatomic) BOOL isOpen;
/** 是否有翻转动画 */
@property (assign, nonatomic) BOOL isFlip;
/** 主标题下所有内容单元格延迟动画效果间隔 */
@property (assign, nonatomic) CGFloat animationDelay;
/** 初始化数据源 */
-(void)initParameters;
/** 创建主标题下所有内容单元格视图 */
-(void)loadItem;
@end
