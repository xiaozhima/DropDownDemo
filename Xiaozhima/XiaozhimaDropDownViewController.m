//
//  XiaozhimaDropDownViewController.m
//  Xiaozhima
//
//  Created by zhangqi on 15/11/18.
//  Copyright © 2015年 Xiaozhima. All rights reserved.
//

#import "XiaozhimaDropDownViewController.h"
#import "DropDownItemDataTool.h"
#import "DropDownItemManager.h"
#import "DropDownItemModel.h"
NSInteger const DROPDOWNITEMTAG = 1000000;
@interface XiaozhimaDropDownViewController ()
/** 数据源 */
@property (strong, nonatomic) NSArray *testArray;
/** 选项视图 */
@property (weak, nonatomic) UISegmentedControl *dropDownItemSegment;
/** 所欲主标题控件对象集合 */
@property (strong, nonatomic) NSMutableArray *managerArray;
@end

@implementation XiaozhimaDropDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}
-(void)viewWillAppear:(BOOL)animated{
    self.managerArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self setUpUI];
}
-(void)setUpUI{
    [_testArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
        DropDownItemManager *itemManager = [[DropDownItemManager alloc] initWithFrame:CGRectMake(SCREENWIDTH / 3 * idx, 64.0f, SCREENWIDTH / 3, 44.0f)];
        itemManager.dropDownItemTitleModel = dictionary[@"title"];
        itemManager.dropDownItemConnectArray = dictionary[@"content"];
        itemManager.iconImageLeftPadding = 10.0f;
        itemManager.tag = DROPDOWNITEMTAG + idx;
        [itemManager addTarget:self action:@selector(itemManagerClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:itemManager];
        [self.managerArray addObject:itemManager];
        /** 单元格主标题点击事件回调 */
        itemManager.mainTitleSelectedBlock = ^(UIControl *manager){
            [self itemManagerClick:(DropDownItemManager *)manager];
        };
        /** 内容单元格点击block回调 */
        itemManager.selectedItemBlock = ^(NSInteger column,NSInteger index){
            [self selectedItemWithColumn:column withIndex:index];
        };
    }];
    [self flipItemType];
    [self gradientChangeItemType];
    [self angleItemType];
}
/** 样式1 */
-(void)flipItemType{
    DropDownItemManager *itemManager = (DropDownItemManager *)[self.view viewWithTag:DROPDOWNITEMTAG];
    itemManager.direction = DropDownItemShowLostDirectionNone;
    itemManager.itemSpace = 5.0f;
    /** 主标题翻转效果  可加可不加 */
    itemManager.isFlip = YES;
    [itemManager loadItem];
}
/** 样式2 */
-(void)gradientChangeItemType{
    DropDownItemManager *itemManager = (DropDownItemManager *)[self.view viewWithTag:DROPDOWNITEMTAG + 1];
    itemManager.itemSpace = 5.0f;
    itemManager.direction = DropDownItemShowLostDirectionBoth;
    /** 主标题下所有内容单元格延迟显示或消失时间间隔效果 可加可不加 */
    itemManager.animationDelay = 0.1f;
    [itemManager loadItem];
}
/** 样式3 */
-(void)angleItemType{
    DropDownItemManager *itemManager = (DropDownItemManager *)[self.view viewWithTag:DROPDOWNITEMTAG + 2];
    itemManager.itemSpace = 5.0f;
    itemManager.animationDelay = 0.1f;
    itemManager.tilt = DropDownItemTiltLeft;
    /** 随机角度 */
    //itemManager.tilt = DropDownItemTiltRandom;
    [itemManager loadItem];
}
#pragma mark-- 单元格主标题点击事件回调
-(void)itemManagerClick:(DropDownItemManager *)itemManager{
    for (DropDownItemManager *manager in _managerArray) {
        if (manager.isOpen && manager != itemManager) {
            manager.isOpen = !manager.isOpen;
        }
    }
    itemManager.isOpen = !itemManager.isOpen;
}
#pragma mark-- 单元格内容点击事件回调
-(void)selectedItemWithColumn:(NSInteger)column withIndex:(NSInteger)itemIndex{
    DropDownItemManager *itemManager = (DropDownItemManager *)[self.view viewWithTag:DROPDOWNITEMTAG + column];
    NSDictionary *dictionary = _testArray[column];
    itemManager.dropDownItemTitleModel = [dictionary[@"content"] objectAtIndex:itemIndex];
}

/** 请求数据 */
-(void)requestData{
    [DropDownItemDataTool getTestDataWithSuccess:^(NSArray *testArray) {
        self.testArray = testArray;
    } Failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
