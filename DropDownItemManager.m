//
//  DropDownItemManager.m
//  Template
//
//  Created by caimiao on 15/11/13.
//  Copyright © 2015年 iOS developer. All rights reserved.
//

#import "DropDownItemManager.h"
#import "DropDownItem.h"
NSInteger const MAINTITLETAG = 1000000;
@interface DropDownItemManager (){
    /** 主标题下所有内容单元格数据源数量 */
    NSInteger itemCount;
    /** 动画时长 */
    CGFloat animationTime;
    /** 动画样式 */
    UIViewAnimationOptions animationOptions;
    
    /** 单元左间距 */
    CGFloat leftSpace;
    /** 单元格size */
    CGSize itemSize;
    /** 单元格origin */
    CGSize itemOrigin;
}
/** 主标题单元格背景承载视图 */
@property (weak, nonatomic) UIView *mainBackgroundView;
/** 单元格icon视图 */
@property (weak, nonatomic) UIImageView *iconImageView;
/** 单元格标题视图 */
@property (weak, nonatomic) UILabel *titleLabel;
/** 主标题下所有内容单元格对象集合数据源 */
@property (strong, nonatomic) NSMutableArray *allContentItemArray;
/** 主标题下所有内容单元格视图透明度渐变值 */
@property (assign, nonatomic) CGFloat itemAlpha;
@end
@implementation DropDownItemManager
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initParameters];
    }
    return self;
}
/** 初始化数据源 */
-(void)initParameters{
    self.tilt = DropDownItemTiltNone;
    self.direction = DropDownItemShowLostDirectionNone;
    _isOpen = NO;
    animationTime = 0.3f;
    animationOptions = UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState;
    _isFlip = NO;
    _itemAlpha = 1.0f;
}
/** 主标题单元格数据源 */
-(void)setDropDownItemTitleModel:(DropDownItemModel *)dropDownItemTitleModel{
    _dropDownItemTitleModel = dropDownItemTitleModel;
    self.iconImageView.image = [UIImage imageNamed:dropDownItemTitleModel.iconImage];
    self.titleLabel.text = dropDownItemTitleModel.title;
}
/** 主标题下所有内容单元格数据源 */
-(void)setDropDownItemConnectArray:(NSArray *)dropDownItemConnectArray{
    _dropDownItemConnectArray = dropDownItemConnectArray;
    itemCount = [_dropDownItemConnectArray count];
}
/** 单元格icon图片距离左视图间距 */
-(void)setIconImageLeftPadding:(CGFloat)iconImageLeftPadding{
    _iconImageLeftPadding = iconImageLeftPadding;
    _iconImageView.frame = CGRectMake(_iconImageLeftPadding, (self.bounds.size.height - 25.0f) / 2.0f, self.bounds.size.width / 3, 25.0f);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 5.0f, 0.0f, CGRectGetWidth(self.bounds) - CGRectGetMaxX(_iconImageView.frame) - 5.0f, CGRectGetHeight(self.bounds));
}
/** 是否展开下拉菜单 */
-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    [self updateDropDownItem];
}
/** 主标题下所有内容单元格视图隐藏属性 */
-(void)setItemAlpha:(CGFloat)itemAlpha{
    if ([self isHiddenWithDirection]) {
        itemAlpha = 0.0f;
    }else{
        itemAlpha = 1.0f;
    }
    _itemAlpha = itemAlpha;
}
/** 根据样式选定内容单元格隐藏属性 */
-(BOOL)isHiddenWithDirection{
    switch (self.direction) {
        case DropDownItemShowLostDirectionNone:
            return NO;
            break;
        case DropDownItemShowLostDirectionLeft:
        case DropDownItemShowLostDirectionRight:
        case DropDownItemShowLostDirectionBoth:
            return YES;
        default:
            return NO;
    }
}
/** 单元格背景承载视图 */
-(UIView *)mainBackgroundView{
    if (!_mainBackgroundView) {
        UIView *mainBgView = [[UIView alloc] initWithFrame:self.bounds];
        mainBgView.backgroundColor = [UIColor whiteColor];
        /** 视图可交互点击 */
        mainBgView.userInteractionEnabled = YES;
        [mainBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dropDownItemTitleClick)]];
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
        titleL.backgroundColor = [UIColor whiteColor];
        titleL.textColor = [UIColor grayColor];
        titleL.font = [UIFont systemFontOfSize:15.0f];
        [self.mainBackgroundView addSubview:titleL];
        _titleLabel = titleL;
    }
    return _titleLabel;
}
#pragma mark-- 主标题视图点击事件
-(void)dropDownItemTitleClick{
    if (self.mainTitleSelectedBlock) {
        self.mainTitleSelectedBlock(self);
    }
}
/** 主标题下所有内容单元格视图 */
-(void)loadItem{
    if (self.tilt == DropDownItemTiltLeft) {
        leftSpace = itemCount * itemCount * self.frame.size.height / 28.0f;
    }
    self.allContentItemArray = [[NSMutableArray alloc] initWithCapacity:itemCount];
    for (NSInteger i = 0;i < itemCount;i++) {
        DropDownItem *item = [[DropDownItem alloc] init];
        item.itemModel = _dropDownItemConnectArray[i];
        item.itemIndex = i;
        item.iconImageLeftPadding = _iconImageLeftPadding;
        [self itemFrame:item];
        [[self superview] addSubview:item];
        [[self superview] sendSubviewToBack:item];
        [item loadItems];
        [_allContentItemArray addObject:item];
        item.itemClickBlock = ^(NSInteger itemIndex){
            [self itemClick:itemIndex];
        };
    }
}
/** 单元格视图位置 */
-(void)itemFrame:(DropDownItem *)item{
    /** 重设主标题下各个单元格位置 */
    item.transform = CGAffineTransformMakeRotation(0);
    CGFloat originX = CGRectGetMinX(self.frame);
    CGFloat originY = 0.0f;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat slidingInOffect =  SCREENWIDTH / 3;
    switch (self.direction) {
        case DropDownItemShowLostDirectionNone:
            originY = CGRectGetMinY(self.frame) + (item.itemIndex + 1) * 2;
            break;
        case DropDownItemShowLostDirectionBoth:
            if (item.itemIndex % 2 == 0) {
                slidingInOffect = 0.0f;
            }else{
                slidingInOffect = slidingInOffect * 2;
            }
            originX = slidingInOffect;
            originY = CGRectGetMinY(self.frame) + (item.itemIndex + 1) * (height + _itemSpace);
            break;
        case DropDownItemShowLostDirectionLeft:
            originX = slidingInOffect * 2;
            originY = (item.itemIndex + 1) * (height + _itemSpace);
            break;
        case DropDownItemShowLostDirectionRight:
            originX = slidingInOffect;
            originY = (item.itemIndex + 1) * (height + _itemSpace);
            break;
        default:
            break;
    }
    self.itemAlpha = [self isHiddenWithDirection];
    item.alpha = _itemAlpha;
    item.frame = CGRectMake(originX, originY, width, height);
}
/** 更新当前下拉菜单视图 */
-(void)updateDropDownItem{
    /** 如果有翻转动画 */
    if (_isFlip) {
        [self mainBackgroundViewFlip];
    }
    /** 展开或合拢下拉菜单 */
    [self openOrCloseDropDownItem];
}
/** 主标题翻转 */
-(void)mainBackgroundViewFlip{
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    flipAnimation.autoreverses = YES;
    flipAnimation.duration = animationTime;
    flipAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DFlip(CATransform3DMakeRotation(M_PI_2 / 2.0f, 1.0f, 0.0f,0.0f),CGPointMake(0.0f, 0.0f),400.0f)];
    [self.mainBackgroundView.layer addAnimation:flipAnimation forKey:nil];
}
/** 主标题翻转动画 */
CATransform3D CATransform3DFlip(CATransform3D angleAndFrame,CGPoint center,float dismissZ){
    return CATransform3DConcat(angleAndFrame, CATransform3DMakeFlip(center, dismissZ));
}
CATransform3D CATransform3DMakeFlip(CGPoint center,float dismissZ){
    CATransform3D transformFromCenter = CATransform3DMakeTranslation(center.x, center.y, 0.0f);
    CATransform3D transformToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0.0f);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f / dismissZ;
    return CATransform3DConcat(CATransform3DConcat(transformToCenter,scale), transformFromCenter);
}
/** 随机角度 */
-(CGFloat)randomAngle{
   return [self randomAngleFromFloat:0.0f toFloat:1.0f];
}
-(CGFloat)randomAngleFromFloat:(CGFloat)angle1 toFloat:(CGFloat)angle2{
    NSInteger startValue = angle1 * MAINTITLETAG;
    NSInteger endValue = angle2 * MAINTITLETAG;
    NSInteger randomAngle = startValue + (arc4random()%(endValue - startValue));
    CGFloat random = randomAngle;
    return (random / MAINTITLETAG);
}
/** 展开或收拢当前下拉菜单 */
-(void)openOrCloseDropDownItem{
    //CGFloat delay = 0.0f;
    [_allContentItemArray enumerateObjectsUsingBlock:^(DropDownItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat delay = 0.0f;
        /** 各个内容单元格显示或消失延迟 产生动画效果*/
        if (_isFlip) {
            delay += 0.1f;
        }
        if ([self isHiddenWithDirection] && self.animationDelay != 0) {
            delay += self.animationDelay * (idx + 1);
        }
        [UIView animateWithDuration:animationTime delay:delay options:animationOptions animations:^{
            [self setUpDropDownItem:item];
        } completion:^(BOOL finished) {
            
        }];
    }];
}
/** 设置各个内容单元格 */
-(void)setUpDropDownItem:(DropDownItem *)item{
    /** 如果是展开动作 */
    if (_isOpen) {
        item.alpha = 1.0f;
        item.frame = [self frameWithOpenItem:item.itemIndex];
        item.transform = [self transformWithOpenItem:item.itemIndex];
    }/** 如果是收拢动作 */
    else{
        item.transform = CGAffineTransformMakeRotation(0.0f);
        item.frame = [self frameWithCloseItem:item];
        if ([self isHiddenWithDirection]) {
            item.alpha = 0.0f;
        }
    }
}
/** 设置各个内容单元格位置 */
-(CGRect)frameWithOpenItem:(NSInteger)itemIndex{
    CGFloat originX = CGRectGetMinX(self.frame);
    CGFloat originY = CGRectGetMinY(self.frame) + (itemIndex + 1) * (self.bounds.size.height + _itemSpace);
    switch (self.tilt) {
        case DropDownItemTiltNone:
            
            break;
        case DropDownItemTiltLeft:
            originX = originX - itemIndex * itemIndex * self.bounds.size.height / 20.0f;
            break;
        case DropDownItemTiltRight:
            originX = originX + itemIndex * itemIndex * self.bounds.size.height / 20.0;
            break;
        case DropDownItemTiltRandom:
            originX = originX + floor([self randomAngle]);
            break;
        default:
            break;
    }
    return CGRectMake(originX, originY, self.bounds.size.width, self.bounds.size.height);
}
/** 设置各个内容单元格动画 */
-(CGAffineTransform)transformWithOpenItem:(NSInteger)itemIndex{
    CGFloat itemAngle = 0.0f;
    switch (self.tilt) {
        case DropDownItemTiltNone:
            
            break;
        case DropDownItemTiltLeft:
            itemAngle = 5.0f * itemIndex / 180.0f * M_PI;
            break;
        case DropDownItemTiltRight:
            itemAngle = -5.0 * itemIndex / 180.0 * M_PI;
            break;
        case DropDownItemTiltRandom:
            itemAngle = floor([self randomAngle] * 15.0f - 5.0f) / 180.0f * M_PI;
            break;
        default:
            break;
    }
    return CGAffineTransformMakeRotation(itemAngle);
}
/** 收拢当前下拉菜单 */
-(CGRect)frameWithCloseItem:(DropDownItem *)item{
    CGFloat originX = CGRectGetMinX(self.frame);
    CGFloat originY = CGRectGetMinY(self.frame) + (item.itemIndex + 1) * 2;
    switch (self.direction) {
        case DropDownItemShowLostDirectionNone:
            originY = CGRectGetMinY(self.frame) + (item.itemIndex + 1) * 2;
            break;
        case DropDownItemShowLostDirectionLeft:
            
            break;
        case DropDownItemShowLostDirectionRight:
            
            break;
        case DropDownItemShowLostDirectionBoth:
            if (item.itemIndex % 2 == 0) {
                originX = 0.0f;
            }else{
                originX = originX * 2;
            }
            originY = CGRectGetMinY(self.frame) + (item.itemIndex + 1) * (self.bounds.size.height + _itemSpace);
            break;
        default:
            break;
    }
    CGRect rect = CGRectMake(originX, originY, item.frame.size.width, item.frame.size.height);
    return rect;
}
#pragma mark-- 内容单元格点击事件
-(void)itemClick:(NSInteger)itemIndex{
    if (self.selectedItemBlock && _isOpen) {
        self.isOpen = !self.isOpen;
        self.selectedItemBlock(self.tag - MAINTITLETAG,itemIndex);
    }
}
@end
