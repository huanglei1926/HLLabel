//
//  HLLabel.h
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLCoreTextData;

@interface HLLabel : UIView

@property (strong, nonatomic) HLCoreTextData *data;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSInteger numberOfLines;
//最大宽度
@property (nonatomic, assign) CGFloat maxWidth;
// 行距
@property (nonatomic, assign) CGFloat linesSpacing;
///**
// *  获取文本真正的高度
// */
//- (int)getHeightWithWidth:(CGFloat)width;

@end
