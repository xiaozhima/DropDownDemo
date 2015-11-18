//
//  DropDownItem.m
//  Xiaozhima
//
//  Created by zhangqi on 15/11/18.
//  Copyright © 2015年 Xiaozhima. All rights reserved.
//
#import "DropDownItem.h"
@interface DropDownItem ()
/** 单元格背景承载视图 */
@property (weak, nonatomic) UIView *mainBackgroundView;
/** 单元格icon视图 */
@property (weak, nonatomic) UIImageView *iconImageView;
/** 单元格标题视图 */
@property (weak, nonatomic) UILabel *titleLabel;
@end
@implementation DropDownItem
/** 重写初始化界面 */
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageLeftPadding = 0.0f;
        [self setUpUI];
    }
    return self;
}
/** 创建主视图 */
-(void)setUpUI{
    [self mainBackgroundView];
    [self iconImageView];
    [self titleLabel];
}
/** 单元格背景承载视图 */
-(UIView *)mainBackgroundView{
    if (!_mainBackgroundView) {
        UIView *mainBgView = [[UIView alloc] init];
        mainBgView.backgroundColor = [UIColor whiteColor];
        /** 视图可交互点击 */
        mainBgView.userInteractionEnabled = YES;
        [mainBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick)]];
        mainBgView.layer.masksToBounds = YES;
        mainBgView.layer.cornerRadius = 6.0f;
        mainBgView.layer.borderWidth = 0.5f;
        mainBgView.layer.borderColor = RGB(246.0f, 120.0f, 180.0f, 1.0f).CGColor;
        /** 增加视图流畅感 */
        mainBgView.layer.shouldRasterize = YES;
        [self addSubview:mainBgView];
        _mainBackgroundView = mainBgView;
    }
    return _mainBackgroundView;
}
/** 单元格icon视图 */
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        UIImageView *iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(_iconImageLeftPadding, (self.bounds.size.height - 25.0f) / 2.0f, self.bounds.size.width / 3, 25.0f)];
        iconIV.backgroundColor = [UIColor clearColor];
        iconIV.contentMode = UIViewContentModeScaleToFill;
        iconIV.clipsToBounds = NO;
        [self.mainBackgroundView addSubview:iconIV];
        _iconImageView = iconIV;
    }
    return _iconImageView;
}
/** 单元格标题视图 */
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleL = [[UILabel alloc] init];
        titleL.backgroundColor = [UIColor clearColor];
        titleL.textColor = [UIColor grayColor];
        titleL.font = [UIFont systemFontOfSize:12.0f];
        [self.mainBackgroundView addSubview:titleL];
        _titleLabel = titleL;
    }
    return _titleLabel;
}
/** 主标题数据源 */
-(void)setItemModel:(DropDownItemModel *)itemModel{
    _itemModel = itemModel;
    self.iconImageView.image = [UIImage imageNamed:itemModel.iconImage];
    self.titleLabel.text = itemModel.title;
}
/** 重设单元格界面视图 */
-(void)loadItems{
    _mainBackgroundView.frame = self.bounds;
    _iconImageView.frame = CGRectMake(_iconImageLeftPadding, (self.bounds.size.height - 20.0f) / 2.0f, self.bounds.size.width / 4, 20.0f);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 5.0f, 0.0f, CGRectGetWidth(self.bounds) - CGRectGetMaxX(_iconImageView.frame) - 5.0f, CGRectGetHeight(self.bounds));
}
#pragma mark 内容单元格交互点击事件
-(void)itemClick{
    if (self.itemClickBlock) {
        self.itemClickBlock(_itemIndex);
    }
}
@end
