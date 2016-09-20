//
//  SegmentationTool.m
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import "SegmentationTool.h"
#import "RegexKitLite.h"
#import "HLCTFrameParserConfig.h"

@implementation SegmentationTool

+ (NSArray *)segmentationString:(NSString *)textStr WithConfig:(HLCTFrameParserConfig *)config
{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSString *text = [textStr copy];
    NSLog(@"text---%@", text);
    NSMutableArray *emotionArray = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:@"\\[(\\w+?):(\\w+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if(captureCount > 2){
            // 图片信息储存
            SegmentationModel *imageStorage = [[SegmentationModel alloc]init];
            imageStorage.type = CoreTextDataTypeEmotion;
            NSString *path = [NSString stringWithFormat:@"EmotionIcons.bundle/default/%@.png",capturedStrings[2]];
            imageStorage.content = path;
            imageStorage.emotionSize = config.emotionSize;
            imageStorage.emotionRange = *capturedRanges;
            [emotionArray addObject:imageStorage];
        }
    }];
    
    [text enumerateStringsSeparatedByRegex:@"\\[(\\w+?):(\\w+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if (captureCount > 2) {
            for (NSInteger i = emotionArray.count - 1; i >= 0; i--) {
                SegmentationModel *model = emotionArray[i];
                if (model.emotionRange.location == (((NSRange)*capturedRanges).location + ((NSRange)*capturedRanges).length)) {
                    if (((NSRange)*capturedRanges).length) {
                        SegmentationModel *textStorage = [[SegmentationModel alloc]init];
                        textStorage.type = CoreTextDataTypeText;
                        NSString *string = capturedStrings[0];
                        textStorage.content = string;
                        textStorage.textColor = config.textColor;
                        textStorage.fontSize = config.fontSize;
                        [dataArray addObject:textStorage];
                    }
                    [dataArray addObject:model];
                    [emotionArray removeObject:model];
                }
            }

        }else{
            if (((NSRange)*capturedRanges).length) {
                SegmentationModel *textStorage = [[SegmentationModel alloc]init];
                textStorage.type = CoreTextDataTypeText;
                NSString *string = capturedStrings[0];
                textStorage.content = string;
                textStorage.textColor = config.textColor;
                textStorage.fontSize = config.fontSize;
                [dataArray addObject:textStorage];
            }
        }
    }];
    
    // 正则匹配图片信息
//    [text enumerateStringsMatchedByRegex:@"\\[(\\w+?):(\\w+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//        NSLog(@"%ld", captureCount);
//        if(captureCount > 2){
//            // 图片信息储存
//            SegmentationModel *imageStorage = [[SegmentationModel alloc]init];
//            imageStorage.type = CoreTextDataTypeEmotion;
//            NSString *path = [NSString stringWithFormat:@"EmotionIcons.bundle/default/%@.png",capturedStrings[2]];
//            imageStorage.content = path;
//            imageStorage.emotionSize = config.emotionSize;
//            [dataArray addObject:imageStorage];
//            
////            imageStorage.range = capturedRanges[0];
////            imageStorage.size = CGSizeMake(20, 20);
////            [tmpArray addObject:imageStorage];
//            
//        }else{
//            NSLog(@"text");
//            SegmentationModel *textStorage = [[SegmentationModel alloc]init];
//            textStorage.type = CoreTextDataTypeText;
//            NSString *string = capturedStrings[0];
//            textStorage.content = string;
//            textStorage.textColor = config.textColor;
//            textStorage.fontSize = config.fontSize;
//            [dataArray addObject:textStorage];
//        }
//    }];

    if (!dataArray.count) {
        return nil;
    }
    return dataArray;
}

@end
