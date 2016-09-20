//
//  HLCTFrameParser.h
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLCoreTextData.h"
#import "HLCTFrameParserConfig.h"
#import "HLCoreTextEmotionData.h"

#import "SegmentationTool.h"

@interface HLCTFrameParser : NSObject

+ (NSMutableDictionary *)attributesWithConfig:(HLCTFrameParserConfig *)config;

+ (HLCoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(HLCTFrameParserConfig *)config;

+ (HLCoreTextData *)parseTemplateText:(NSString *)text config:(HLCTFrameParserConfig *)config;

@end
