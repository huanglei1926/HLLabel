//
//  HLCTFrameParser.m
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import "HLCTFrameParser.h"


@implementation HLCTFrameParser

static CGFloat ascentCallback(void *ref){
    return ((__bridge HLCTFrameParserConfig*)ref).emotionSize.height;
}

static CGFloat descentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void* ref){
    return ((__bridge HLCTFrameParserConfig*)ref).emotionSize.width;
}


+ (NSMutableDictionary *)attributesWithConfig:(HLCTFrameParserConfig *)config {
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor * textColor = config.textColor;

    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    
    return dict;
}

+ (HLCoreTextData *)parseTemplateText:(NSString *)text config:(HLCTFrameParserConfig *)config {
    NSMutableArray *imageArray = [NSMutableArray array];
    NSAttributedString *content = [self loadTemplateText:text config:config
                                              imageArray:imageArray];
    HLCoreTextData *data = [self parseAttributedContent:content config:config];
    data.imageArray = imageArray;
    return data;
}

+ (NSAttributedString *)loadTemplateText:(NSString *)text
                                  config:(HLCTFrameParserConfig *)config
                              imageArray:(NSMutableArray *)imageArray
{
    NSString *textStr = [text copy];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    if (textStr) {
        NSArray *array = [SegmentationTool segmentationString:textStr WithConfig:config];
        if ([array isKindOfClass:[NSArray class]]) {
            for (SegmentationModel *model in array) {
                CoreTextDataType type = model.type;
                if (type == CoreTextDataTypeText) {
                    NSAttributedString *as = [self parseAttributedContentFromSegmentationModel:model config:config];
                    [result appendAttributedString:as];
                } else if (type == CoreTextDataTypeEmotion) {
                    // 创建 CoreTextImageData
                    HLCoreTextEmotionData *imageData = [[HLCoreTextEmotionData alloc] init];
                    imageData.name = model.content;
                    imageData.position = [result length];
                    [imageArray addObject:imageData];
                    // 创建空白占位符，并且设置它的CTRunDelegate信息
                    NSAttributedString *as = [self parseImageDataFromSegmentationModel:model config:config];
                    [result appendAttributedString:as];
                }
            }
        }
    }
    return result;
}



+ (NSAttributedString *)parseImageDataFromSegmentationModel:(SegmentationModel *)model
                                                config:(HLCTFrameParserConfig *)config {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(config));
    
    // 使用0xFFFC作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1),kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}

+ (NSAttributedString *)parseAttributedContentFromSegmentationModel:(SegmentationModel *)model
                                                        config:(HLCTFrameParserConfig *)config {
    NSMutableDictionary *attributes = [self attributesWithConfig:config];
    NSString *content = model.content;
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}

+ (HLCoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(HLCTFrameParserConfig *)config {
    // 创建CTFramesetterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    // 获得要缓制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,content.length), NULL, restrictSize, NULL);
    CGFloat textHeight = coreTextSize.height;
    
    // 生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight contentLength:content.length];
    
    HLCoreTextData *data = [[HLCoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    data.content = content;
    
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}

+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(HLCTFrameParserConfig *)config
                                  height:(CGFloat)height contentLength:(NSUInteger)length{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, length), path, NULL);
    
    CFRelease(path);
    return frame;
}

@end
