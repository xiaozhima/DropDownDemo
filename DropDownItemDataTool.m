//
//  DropDownItemDataTool.h
//  Xiaozhima
//
//  Created by zhangqi on 15/11/18.
//  Copyright © 2015年 Xiaozhima. All rights reserved.
//

#import "DropDownItemDataTool.h"
#import "DropDownItemModel.h"
@implementation DropDownItemDataTool
+(void)getTestDataWithSuccess:(void(^)(NSArray *itemArray))success Failure:(void(^)(NSError *error))failure{
    NSMutableArray *itemArray1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *itemDictionary11 = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableArray *itemArray2 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *itemDictionary22 = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableArray *itemArray3 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *itemDictionary33 = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableArray *itemArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i=0; i<5; i++) {
        DropDownItemModel *model = [[DropDownItemModel alloc] init];
        model.iconImage = [NSString stringWithFormat:@"%li.jpg",i+4];
        switch (i) {
            case 0:
                model.title = @"超级赛亚人";
                break;
            case 1:
                model.title = @"去哪哪死人";
                break;
            case 2:
                model.title = @"出轨不劈腿";
                break;
            case 3:
                model.title = @"死神吹笛人";
                break;
            case 4:
                model.title = @"宁静小树屋";
                break;
            default:
                break;
        }
        [itemArray1 addObject:model];
    }
    DropDownItemModel *itemModel11 = [[DropDownItemModel alloc] init];
    itemModel11.title = @"动漫1";
    itemModel11.iconImage = [NSString stringWithFormat:@"8.jpg"];
    [itemDictionary11 setObject:itemArray1 forKey:@"content"];
    [itemDictionary11 setObject:itemModel11 forKey:@"title"];
    [itemArray addObject:itemDictionary11];
    for (NSInteger j=0; j<6; j++) {
        DropDownItemModel *model = [[DropDownItemModel alloc] init];
        model.iconImage = [NSString stringWithFormat:@"%li.jpg",j+9];
        switch (j) {
            case 0:
                model.title = @"白银座魔琴";
                break;
            case 1:
                model.title = @"黑珍珠";
                break;
            case 2:
                model.title = @"弗利萨";
                break;
            case 3:
                model.title = @"红发海贼团";
                break;
            case 4:
                model.title = @"死神";
                break;
            case 5:
                model.title = @"小丑巴基船长";
                break;
            default:
                break;
        }
        [itemArray2 addObject:model];
    }
    DropDownItemModel *itemModel22 = [[DropDownItemModel alloc] init];
    itemModel22.title = @"动漫2";
    itemModel22.iconImage = [NSString stringWithFormat:@"4.jpg"];
    [itemDictionary22 setObject:itemArray2 forKey:@"content"];
    [itemDictionary22 setObject:itemModel22 forKey:@"title"];
    [itemArray addObject:itemDictionary22];
    for (NSInteger k=0; k<4; k++) {
        DropDownItemModel *model = [[DropDownItemModel alloc] init];
        model.iconImage = [NSString stringWithFormat:@"%li.jpg",k+1];
        switch (k) {
            case 0:
                model.title = @"动物世界";
                break;
            case 1:
                model.title = @"鸣人cp";
                break;
            case 2:
                model.title = @"海贼同人";
                break;
            case 3:
                model.title = @"超级赛亚人";
                break;
            default:
                break;
        }
        [itemArray3 addObject:model];
    }
    DropDownItemModel *itemModel33 = [[DropDownItemModel alloc] init];
    itemModel33.title = @"动漫3";
    itemModel33.iconImage = [NSString stringWithFormat:@"13.jpg"];
    [itemDictionary33 setObject:itemArray3 forKey:@"content"];
    [itemDictionary33 setObject:itemModel33 forKey:@"title"];
    [itemArray addObject:itemDictionary33];
    success(itemArray);
}
@end
