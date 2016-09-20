//
//  HLLabel.m
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import "HLLabel.h"
#import <CoreText/CoreText.h>
#import "HLCoreTextEmotionData.h"
#import "HLCoreTextData.h"

#define UIColorFromHLRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

@implementation HLLabel

- (instancetype)init
{
    if (self = [super init]) {
        _fontSize = 14.0;
        _textColor = UIColorFromHLRGBA(0x333333, 1);
        _numberOfLines = 0;
        _maxWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//    }
//    return self;
//}

- (void)setData:(HLCoreTextData *)data
{
    _data = data;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.data == nil) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw(self.data.ctFrame, context);
    
    for (HLCoreTextEmotionData *imageData in self.data.imageArray) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }

}


@end
