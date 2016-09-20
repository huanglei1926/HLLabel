//
//  HLCTFrameParserConfig.m
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import "HLCTFrameParserConfig.h"
#define RGB(A, B, C)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

@implementation HLCTFrameParserConfig

- (id)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _width = [UIScreen mainScreen].bounds.size.width - 22;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = RGB(108, 108, 108);
        _emotionSize = CGSizeMake(20, 20);
    }
    return self;
}

@end
