//
//  HLCTFrameParserConfig.h
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HLCTFrameParserConfig : NSObject

@property (nonatomic, assign) CGFloat width;
//@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CGSize emotionSize;

@end
